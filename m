Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131705AbRCXPg7>; Sat, 24 Mar 2001 10:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131707AbRCXPgt>; Sat, 24 Mar 2001 10:36:49 -0500
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:53684 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S131705AbRCXPgr>; Sat, 24 Mar 2001 10:36:47 -0500
Date: Sat, 24 Mar 2001 16:36:05 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Michael Devogelaere <michael@digibel.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: network unusable
Message-ID: <20010324163605.W11126@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <Pine.LNX.4.21.0103232233030.29774-100000@gisco.digibel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.21.0103232233030.29774-100000@gisco.digibel.be>; from michael@digibel.be on Fri, Mar 23, 2001 at 10:44:58PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2001 at 10:44:58PM +0100, Michael Devogelaere wrote:
> I'm experiencing problems with an rtl8029-nic. The computer acts as a
> multicast-client receiving a disk-image from a server. That transfer went
> fine during the first 1.5 gb and then the machine stopped responding.
> I tried to ping it, but got no answer. On the machine i see that the
> error-packets (/sbin/ifconfig) grow very fast, but the machine cannot
> send or receive anymore.  The arp-table contains 00:00:.. for all 
> hw-addresses.  Dmesg shows: 
> eth0: bogus packet size: 65360, status=0x0 nxpg=0x0
> (repeated for 100+ times)
> 
> The machine runs kernel 2.4.2 without module-support. All other participating 
> computers have exactly the same hardware and software (they were all cloned 
> with ghost).  If i restart the program, everything goes fine for some 
> minutes and then another computer crashes with exactly the same symptoms.
> When i restart the network-configuration, everything seems to work again.

Could you tell more about your hardware? Does it still happen
with 2.4.2-ac20 (which I consider most stable for now ;-))?

Full dmesg from booting and after inserting the proper networking
modules, your .config and lscpi -vvvv would be nice.

I don't experience any problems like that here.

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
