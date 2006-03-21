Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbWCUSHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbWCUSHR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 13:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWCUSHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 13:07:16 -0500
Received: from terminus.zytor.com ([192.83.249.54]:4283 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932357AbWCUSHP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 13:07:15 -0500
Message-ID: <442040CB.2020201@zytor.com>
Date: Tue, 21 Mar 2006 10:07:07 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: VFAT: Can't create file named 'aux.h'?
References: <1142890822.5007.18.camel@localhost.localdomain> <20060320134533.febb0155.rdunlap@xenotime.net> <dvn835$lvo$1@terminus.zytor.com> <Pine.LNX.4.61.0603211840020.21376@yvahk01.tjqt.qr> <44203B86.5000003@zytor.com> <Pine.LNX.4.61.0603211854150.21376@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0603211854150.21376@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>>NAK. How much more names will you be going to mangle because of FAT
>>>character restrictions? (< and > are one of the chars not allowed in FAT.)
>>
>>Uhm... that's what VFAT *does*...
>>
> 
> Hm. How do I check? Under a DOS shell,
> 
> 	echo bla >"illegal>name"
> 
> won't work, and creating a new empty dummy text file within Windows 
> Explorer with this illegal>name won't work either.
> (http://jengelh.hopto.org/f/illegal_filename.jpg)
> Did I miss some magic WINAPI function that does allow it implicitly
> by mangling the name?

You're confusing characters which aren't legal *VFAT* names which those 
which aren't legal *FAT* (8.3) names.

 > is illegal in VFAT as well.

	-hpa
