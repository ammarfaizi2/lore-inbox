Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030402AbWHACqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030402AbWHACqN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 22:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030405AbWHACqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 22:46:13 -0400
Received: from terminus.zytor.com ([192.83.249.54]:55187 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1030402AbWHACqN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 22:46:13 -0400
Message-ID: <44CEC068.9060409@zytor.com>
Date: Mon, 31 Jul 2006 19:46:00 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Matt Mackall <mpm@selenic.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] x86_64 built-in command line
References: <20060731171442.GI6908@waste.org> <44CEBEAF.8030203@zytor.com> <20060801024102.GS6908@waste.org> <200608010444.04681.ak@suse.de>
In-Reply-To: <200608010444.04681.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Tuesday 01 August 2006 04:41, Matt Mackall wrote:
>> On Mon, Jul 31, 2006 at 07:38:39PM -0700, H. Peter Anvin wrote:
>>> Actually, the best thing to do might be to designate a symbol (say &, 
>>> like in automount) as "insert the boot loader command line here."
>>>
>>> That way you can specify things in the builtin command line that are 
>>> both prepended and appended to the boot loader command, and if you wish, 
>>> you can emit it completely.
>>>
>>> The default would be just "&".
>> That idea doesn't suck. I'll take a look at it.
> 
> With %s it would be much less code to write.
> 

True; it would just mean that the buildin command line would have to 
double %'s, but that's not really a problem.

On the other hand, a single-character substitution loop is hardly complex.

	-hpa
