Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276814AbRJCAqg>; Tue, 2 Oct 2001 20:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276815AbRJCAqQ>; Tue, 2 Oct 2001 20:46:16 -0400
Received: from noodles.codemonkey.org.uk ([62.49.180.5]:22703 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S276814AbRJCAqN>; Tue, 2 Oct 2001 20:46:13 -0400
Date: Wed, 3 Oct 2001 01:45:05 +0100
From: Dave Jones <davej@suse.de>
To: powertweak-linux@lists.sourceforge.net
Cc: linuxperf@nl.linux.org, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] Powertweak v0.99.4
Message-ID: <20011003014505.A7063@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>, powertweak-linux@lists.sf.net,
	linuxperf@nl.linux.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just uploaded v0.99.4 (a bugfix only release) of Powertweak,
the hardware configuration/tuning tool to
http://sourceforge.net/project/showfiles.php?group_id=253

v0.99.3 announced a few days ago had quite a few problems,
which this release fixes. As well as those documented below
there have been various fixes to get the code building on
various strange glibc/gcc/autoconf's

This stands a much greater chance of working than the
previous release, which I'll now pretend never happened.


v0.99.4 [Release 22. -- The 'Bug Barbecue' release ]

- Bugfixes:
  - 'Disk' Submenu works again.
  - CPU backend cleanups.
    - Was using memory after free()
    - 'BrandName' field removed, and CPUName field improved.
    - CPU Name can now be any length. 
    - Now cleans identity structure prior to use. 
  - hdparm backend got an overdue cleanup.
    - tweaks no longer carry excess ioctl info.
    - allocation routines made simpler.
  - Only 'Tree' elements of the tree are now sorted. 
  - When backends failed, we were dereferencing freed memory. 
  - Sonypi backend now unloads if no Sonypi hardware present.
  - PCI backend tried to read past byte 255 of config space.
														  

-- 
| Dave Jones.                    http://www.codemonkey.org.uk
| SuSE Labs .
