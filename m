Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266890AbUGLQgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266890AbUGLQgQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 12:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266888AbUGLQgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 12:36:16 -0400
Received: from 209-128-98-078.bayarea.net ([209.128.98.78]:2789 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S266887AbUGLQe6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 12:34:58 -0400
Message-ID: <40F2BD93.3090505@zytor.com>
Date: Mon, 12 Jul 2004 09:34:27 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Florian Weimer <fw@deneb.enyo.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
References: <20040707122525.X1924@build.pdx.osdl.net>	<Pine.LNX.4.58.0407080855120.1764@ppc970.osdl.org>	<Pine.LNX.4.58.0407091313570.20635@scrub.home>	<Pine.GSO.4.58.0407102126150.10242@waterleaf.sonytel.be>	<ccs6j2$b8a$1@terminus.zytor.com> <87r7rhb4jw.fsf@deneb.enyo.de>
In-Reply-To: <87r7rhb4jw.fsf@deneb.enyo.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Weimer wrote:
> * H. Peter Anvin:
> 
> 
>>Followup to:  <Pine.GSO.4.58.0407102126150.10242@waterleaf.sonytel.be>
>>By author:    Geert Uytterhoeven <geert@linux-m68k.org>
>>In newsgroup: linux.dev.kernel
>>
>>>  - `return f();' in a function returning void (where f() returns void as well)
>>>
>>
>>Considering this one a bug is daft in the extreme.
>>
>>Why?  Because "return f();" is the only kind of tailcall syntax C has,
> 
> 
> Huh?  If you remove the "return", it's still a valid tailcall syntax
> (at least from GCC's perspective).

Yes, but as I said in the portion of the message you deleted, it means you 
have to use a different syntax with void functions as for all other functions.

That is daft in the extreme.

	-hpa

