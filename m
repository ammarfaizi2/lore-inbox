Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751063AbWHAVyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbWHAVyz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 17:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWHAVyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 17:54:54 -0400
Received: from terminus.zytor.com ([192.83.249.54]:5862 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751063AbWHAVyy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 17:54:54 -0400
Message-ID: <44CFCD35.8080103@zytor.com>
Date: Tue, 01 Aug 2006 14:52:53 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: ricknu-0@student.ltu.se, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Alexey Dobriyan <adobriyan@gmail.com>,
       Vadim Lobanov <vlobanov@speakeasy.net>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Shorty Porty <getshorty_@hotmail.com>,
       Peter Williams <pwil3058@bigpond.net.au>, Michael Buesch <mb@bu3sch.de>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>, larsbj@gullik.net,
       Paul Jackson <pj@sgi.com>, Josef Sipek <jsipek@fsl.cs.sunysb.edu>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>,
       Nicholas Miell <nmiell@comcast.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Lars Noschinski <cebewee@gmx.de>
Subject: Re: [PATCH 1/2] include/linux: Defining bool, false and true
References: <1154175570.44cb5252d3f09@portal.student.luth.se> <1154176331.44cb554b633ef@portal.student.luth.se> <44CFA934.9010404@zytor.com> <1154466739.44cfc3b34a222@portal.student.luth.se> <44CFC59A.5050609@zytor.com> <44CFC837.5080700@garzik.org> <44CFCABC.6040406@zytor.com> <44CFCC1B.8080509@garzik.org>
In-Reply-To: <44CFCC1B.8080509@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> H. Peter Anvin wrote:
>> Jeff Garzik wrote:
>>> H. Peter Anvin wrote:
>>>> There is no enum involved.
> 
>>> There should be.  It makes more information available to the C 
>>> compiler, and it makes useful symbols available to the debugger.
> 
>> _Bool is a native C type; it has all the information the C compiler 
>> needs.
> 
> "#define true 1" however does not.
> 

I guess that's fair, although when you put it into a type _Bool they're 
going to devolve to pure constants.

	-hpa
