Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964865AbWIVS1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbWIVS1f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 14:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbWIVS1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 14:27:35 -0400
Received: from terminus.zytor.com ([192.83.249.54]:61865 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964865AbWIVS1d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 14:27:33 -0400
Message-ID: <45142AF1.1090806@zytor.com>
Date: Fri, 22 Sep 2006 11:26:57 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Michael Tokarev <mjt@tls.msk.ru>
CC: Johannes Stezenbach <js@linuxtv.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Dax Kelson <dax@gurulabs.com>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Smaller compressed kernel source tarballs?
References: <1158870777.24172.23.camel@mentorng.gurulabs.com> <20060921204250.GN13641@csclub.uwaterloo.ca> <45130792.9040104@zytor.com> <20060922140007.GK13639@csclub.uwaterloo.ca> <Pine.LNX.4.61.0609221811560.12304@yvahk01.tjqt.qr> <4514103D.8010303@zytor.com> <20060922174137.GA29929@linuxtv.org> <451426C9.9040002@zytor.com> <4514292C.5000309@tls.msk.ru>
In-Reply-To: <4514292C.5000309@tls.msk.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Tokarev wrote:
> 
> Well, I don't see any shell code here, in /usr/bin/lzma as in istalled from
> debian version 4.43-2.
> 
> But note that this lzma utility does not have any 'magic number' and does
> no crc checks.

Ah, right, that's a total killer.

> On the site it's said lzma(sdk) is under rewrite to support
> new format with magic number and crc checks...

That is an absolute must, IMO.  I would use the gzip format as a base.

	-hpa

