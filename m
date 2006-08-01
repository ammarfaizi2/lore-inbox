Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbWHAVYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbWHAVYL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 17:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbWHAVYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 17:24:11 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:59837 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750831AbWHAVYK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 17:24:10 -0400
Message-ID: <44CFC669.1040709@garzik.org>
Date: Tue, 01 Aug 2006 17:23:53 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
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
References: <1154175570.44cb5252d3f09@portal.student.luth.se> <1154176331.44cb554b633ef@portal.student.luth.se> <44CFA934.9010404@zytor.com>
In-Reply-To: <44CFA934.9010404@zytor.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> ricknu-0@student.ltu.se wrote:
>> This patch defines:
>> * a generic boolean-type, named "bool"
>> * aliases to 0 and 1, named "false" and "true"
>>
>> Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>
> 
> Shouldn't this simply use _Bool?

No sane person should use "_Bool" in real code.  Unnecessary StudlyCaps 
and unnecessary underscore.

"bool" is far easier to type, and looks less weird.

	Jeff



