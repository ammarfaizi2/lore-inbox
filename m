Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286350AbRLTTt7>; Thu, 20 Dec 2001 14:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286357AbRLTTto>; Thu, 20 Dec 2001 14:49:44 -0500
Received: from quechua.inka.de ([212.227.14.2]:18272 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S286350AbRLTTt1>;
	Thu, 20 Dec 2001 14:49:27 -0500
From: Bernd Eckenfels <usenet2001-12@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Changing KB, MB, and GB to KiB, MiB, and GiB in Configure.help.
In-Reply-To: <200112201721.KAA05522@tstac.esa.lanl.gov>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E16H9C4-0005ST-00@sites.inka.de>
Date: Thu, 20 Dec 2001 20:49:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200112201721.KAA05522@tstac.esa.lanl.gov> you wrote:
> Eric has decided to follow the following standard:
> IEC 60027-2, Second edition, 2000-11, 
> Letter symbols to be used in electrical technology -
> Part 2: Telecommunications and electronics.
> and has changed all the abbreviations for Kilobyte (KB) to KiB,
> Megabyte (MB) to MiB, etc, etc.

I did this for nettools (i.e. ifconfig), too:

          RX bytes:2120660294 (1.9 GiB)  TX bytes:341183013 (325.3 MiB)

man page:

       Since net-tools 1.60-4 ifconfig is printing byte  counters
       with  SI  units. So 1 KiB are 2^10 byte. Note, the numbers
       are truncated to one decimal (which can by quite  a large
       error if you consider 0.1 PiB is 112.589.990.684.262 bytes :)
...
SEE ALSO
       route(8), netstat(8), arp(8), rarp(8), ipchains(8)
       http://physics.nist.gov/cuu/Units/binary.html  -  Prefixes
       for binary multiples
				   
