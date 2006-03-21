Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751499AbWCUR6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbWCUR6N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 12:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWCUR6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 12:58:13 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:52873 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751499AbWCUR6M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 12:58:12 -0500
Date: Tue, 21 Mar 2006 18:58:10 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: VFAT: Can't create file named 'aux.h'?
In-Reply-To: <44203B86.5000003@zytor.com>
Message-ID: <Pine.LNX.4.61.0603211854150.21376@yvahk01.tjqt.qr>
References: <1142890822.5007.18.camel@localhost.localdomain>
 <20060320134533.febb0155.rdunlap@xenotime.net> <dvn835$lvo$1@terminus.zytor.com>
 <Pine.LNX.4.61.0603211840020.21376@yvahk01.tjqt.qr> <44203B86.5000003@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> NAK. How much more names will you be going to mangle because of FAT
>> character restrictions? (< and > are one of the chars not allowed in FAT.)
>
> Uhm... that's what VFAT *does*...
>
Hm. How do I check? Under a DOS shell,

	echo bla >"illegal>name"

won't work, and creating a new empty dummy text file within Windows 
Explorer with this illegal>name won't work either.
(http://jengelh.hopto.org/f/illegal_filename.jpg)
Did I miss some magic WINAPI function that does allow it implicitly
by mangling the name?


Jan Engelhardt
-- 
| Software Engineer and Linux/Unix Network Administrator
