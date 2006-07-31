Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbWGaTfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWGaTfl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 15:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbWGaTfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 15:35:40 -0400
Received: from terminus.zytor.com ([192.83.249.54]:40915 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932190AbWGaTfe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 15:35:34 -0400
Message-ID: <44CE5B74.4060409@zytor.com>
Date: Mon, 31 Jul 2006 12:35:16 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] x86 built-in command line (resend)
References: <20060731171259.GH6908@waste.org> <44CE54D6.4040309@zytor.com> <20060731192844.GK6908@waste.org>
In-Reply-To: <20060731192844.GK6908@waste.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> On Mon, Jul 31, 2006 at 12:07:02PM -0700, H. Peter Anvin wrote:
>> Matt Mackall wrote:
>>> I'm resending this as-is because the earlier thread petered out
>>> without any strong arguments against this approach. x86_64 patch to
>>> follow.
>> "No strong arguments?"
>>
>> I still maintain that this patch has the wrong priority in case more 
>> than one set of arguments are provided.
> 
> But you still haven't answered how that lets you work around firmware
> that passes parameters you don't like.
> 

That a fairly unique problem, and is most likely in a minority 
application.  For that case a CONFIG option to ignore the 
firmware-provided command line would make sense.  I do not believe it 
should be the only option or even the default.

It would be particularly good if this could be standardized across 
architectures, which is another reason to do it right.

	-hpa

