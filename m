Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277228AbRKVLLL>; Thu, 22 Nov 2001 06:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277294AbRKVLLB>; Thu, 22 Nov 2001 06:11:01 -0500
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:46297 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S277228AbRKVLKs>; Thu, 22 Nov 2001 06:10:48 -0500
From: Cristian CONSTANTIN <constantin@fokus.gmd.de>
Date: Thu, 22 Nov 2001 12:10:36 +0100
To: Pim Zandbergen <P.Zandbergen@macroscoop.nl>
Cc: linux-kernel@vger.kernel.org, "Justin T. Gibbs" <gibbs@scsiguy.com>
Subject: Re: aic7xxx freezes with kernel 2.4.13
Message-ID: <20011122121036.V24162@terix.fokus.gmd.de>
In-Reply-To: <c8iiutoqe1grq0hr0h1htt5gnpbnh3k91f@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8iiutoqe1grq0hr0h1htt5gnpbnh3k91f@4ax.com>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2001 at 04:20:17PM +0100, Pim Zandbergen wrote:
> Hi,
> 
> I've got a Dell PowerEdge 1300 with dual PIII's and dual aic7xxx
> controllers. One controller is onboard, the other is in a PCI slot.
> 
> The system is running Red Hat 7.1 with kernel 2.4.13.
> 
> Lately, this system is experiencing freezes that may last one or two
> minutes. These usually occur during heavy Samba activity. After the
> freeze, the system usually recovers, but by then, the Samba clients
> have timed out their operations.
> 
> Syslog shows the freezes are related to the SCSI subsystem. I'm having
> trouble interpreting this information. Is my hardware suspect or could
> this be a driver bug?
> 
> Syslog entries (with aic7xxx=verbose) showing the boot process and a
> system freeze can be found on
> 
> http://www.macroscoop.nl/~pim/aic7xxx/syslog.html (98.080 bytes) or
> http://www.macroscoop.nl/~pim/aic7xxx/syslog.gz   (6.410 bytes)
> 

cristian: same problem here. posted some time ago on linux-kernel and
some days ago on linux-scsi. no solution so far...

my config, in a very few words:
- tyan SMP motherboard + 2xAthlon
- adaptec aic7xxx (2 onboard 1 PCI - tried with all of them, same
  result)
- IBM HDD - mines are the 36 GB model - 
http://www.storage.ibm.com/hdd/ultra/ul36lzx.htm 
it seems yours are the 18 GB model - 
http://www.storage.ibm.com/hdd/ultra/ul18es.htm  
(more details in the postings on linux-kernel, linux-scsi)

is adaptec+ibm a "dangerous" combination??
what is strange is that the "freezing" behaviour appears randomly, even
though it seems to be connected to "heavy" accesses to the HDD.

please let me know if you have found a solution for this problem,

thanks!
bye now!
-- 
 _          |(4) Any person who knowingly and without authorization uses,
(_'_        |accesses or attempts to access any computer, computer system,
  (_'rist   |computer network, or any computer software, program,
            |documentation or data contained in such computer, computer
            |system or computer network, commits computer crime.
            |                --Oregon Computer Crime Law
GPG public key at https://www.mobile-ip.de/~crist/constantin.key
