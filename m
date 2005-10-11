Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbVJKPX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbVJKPX2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 11:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbVJKPX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 11:23:28 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:23734 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S932126AbVJKPX1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 11:23:27 -0400
Message-ID: <4960.192.168.201.6.1129044201.squirrel@pc300>
In-Reply-To: <200510111656.30403.vda@ilport.com.ua>
References: <2031.192.168.201.6.1128591983.squirrel@pc300>
    <200510111656.30403.vda@ilport.com.ua>
Date: Tue, 11 Oct 2005 16:23:21 +0100 (BST)
From: "Etienne Lorrain" <etienne.lorrain@masroudeau.com>
To: "Denis Vlasenko" <vda@ilport.com.ua>
Cc: linux-kernel@vger.kernel.org
Reply-To: etienne.lorrain@masroudeau.com
User-Agent: SquirrelMail/1.4.5
MIME-Version: 1.0
X-Priority: 3 (Normal)
Importance: Normal
X-SA-Exim-Connect-IP: 192.168.2.240
X-SA-Exim-Mail-From: etienne.lorrain@masroudeau.com
Subject: Re: [PATCH 1/3] Gujin linux.kgz boot format
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on cygne.masroudeau.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vda wrote:
>>  This linux-*.kgz format is the "native" format of the Gujin
>> bootloader which can be found here:
>> http://gujin.org
>
> /me looking at the site
> Wow. Isn't this overdesigned by wide margin?

  Well, you will see Gujin with its video/mouse interface on the WEB,
 because there is no point in just showing the tiny interface which
 does not even detect which video mode (or serial interface) is
 available. For that just imagine two line of text, the first being
 the copyright, the second a set of point indicating the progress
 being done loading from BIOS or from DOS.

  Now if you want to tell me that it is a lot easier to write code
 using GCC compared to an assembler, well I quite agree. The source
 code size is approx the same as Grub, with a lot less files.
 It is also a lot simpler to use the BIOS than to rewrite everything
 to be able to switch to protected mode.

> Apart from shaving a few kb's from kernel image (which are discarded
> anyway after boot, IIRC), what advantages does this bring?
> Do they outweigh effort needed to maintain it?

  Don't you think autodetection of the ways to boot a PC is a nice
 feature, so that you just have _one_ rescue CDROM/floppy/pen drive
 from now on? Also you just test a new Linux distribution without
 changing your current bootloader configuration? At least, you do
 not end up having 3 or 4 Grub and two LILO configured in 6 different
 root filesystems, some of them on removeable HD...

  Moreover, there is no need to provide boot floppies to install
 distributions on PC which cannot boot CDROMs, just give a way
 to make a Gujin floppy. It will load big kernel directly from
 the CDROM ISO9660 filesystem, in /boot directory.

  Etienne.

