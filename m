Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbWCURlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbWCURlw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 12:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbWCURlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 12:41:52 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:23483 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932348AbWCURlv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 12:41:51 -0500
Date: Tue, 21 Mar 2006 18:41:47 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: VFAT: Can't create file named 'aux.h'?
In-Reply-To: <dvn835$lvo$1@terminus.zytor.com>
Message-ID: <Pine.LNX.4.61.0603211840020.21376@yvahk01.tjqt.qr>
References: <1142890822.5007.18.camel@localhost.localdomain>
 <20060320134533.febb0155.rdunlap@xenotime.net> <dvn835$lvo$1@terminus.zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> "AUX" is (was) a reserved "filename" in DOS.  The Linux MS-DOS
>> filesystem preserves (protects) that.  The extension part does not
>> matter; it only checks the first 8 characters of the filename.
>> You'll need to use a different filesystem or filename...
>
>But this is VFAT, not FAT.  It should probably take the reserved name
>and mangle it.
>
NAK. How much more names will you be going to mangle because of FAT 
character restrictions? (< and > are one of the chars not allowed in FAT.)

>There should be more than that.  At the very least there is "CLOCK$"
>(arguably anything with $), "MSCD001" (and probably more than 001), as
>well as "COM5".."COM8".
>
Objection too. You can create these files without a problem within Win98, 
so it shall remain possible under Linux too.


Jan Engelhardt
-- 
| Software Engineer and Linux/Unix Network Administrator
