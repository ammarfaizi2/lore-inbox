Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbVIPWI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbVIPWI3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 18:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbVIPWI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 18:08:29 -0400
Received: from terminus.zytor.com ([209.128.68.124]:37274 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750700AbVIPWI3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 18:08:29 -0400
Message-ID: <432B424A.4020508@zytor.com>
Date: Fri, 16 Sep 2005 15:08:10 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?=22Martin_v=2E_L=F6wis=22?= <martin@v.loewis.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Patch] Support UTF-8 scripts
References: <4NsP0-3YF-11@gated-at.bofh.it> <4NsP0-3YF-13@gated-at.bofh.it> <4NsP0-3YF-15@gated-at.bofh.it> <4NsP0-3YF-17@gated-at.bofh.it> <4NsP1-3YF-19@gated-at.bofh.it> <4NsP1-3YF-21@gated-at.bofh.it> <4NsOZ-3YF-9@gated-at.bofh.it> <4NsYH-4bv-27@gated-at.bofh.it> <4NtBr-4WU-3@gated-at.bofh.it> <4Nu4p-5Js-3@gated-at.bofh.it> <432B2E09.9010407@v.loewis.de>
In-Reply-To: <432B2E09.9010407@v.loewis.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin v. Löwis wrote:
> In programming languages that support the notion of source encodings,
> you do have markers for 8-bit encodings. For example, in Python, you
> can specify
> 
> # -*- coding: iso-8859-1 -*-
> 
> to denote the source encoding. In Perl, you write
> 
> use encoding "latin-1";
> 
> (with 'use utf8;' being a special-case shortcut).
> 
> In Java, you can specify the encoding through the -encoding argument
> to javac. In gcc, you use -finput-charset (with the special case of
> -fexec-charset and -fwide-exec-charset potentially being different).
> 
> So you *must* use encoding declarations in some languages; the UTF-8
> signature is a particularly convenient way of doing so, since it allows
> for uniformity across languages, with no need for the text editors to
> parse all the different programming languages.

Did you miss the point?  There has been a standard for marking for *30 
years*, and virtually NOONE (outside Japan) uses it.

	-hpa
