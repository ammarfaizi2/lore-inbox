Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbVHAVtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbVHAVtv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 17:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbVHAVXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 17:23:48 -0400
Received: from sabe.cs.wisc.edu ([128.105.6.20]:29847 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S261220AbVHAVXg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 17:23:36 -0400
Message-ID: <3059.24.240.41.150.1122931398.squirrel@69.129.69.193>
In-Reply-To: <1122458769.7773.39.camel@localhost.localdomain>
References: <20050727092613.GA4713@elf.ucw.cz> 
    <20050727023754.6846f3a2.akpm@osdl.org> 
    <20050727095324.GE4270@elf.ucw.cz>
    <1122458769.7773.39.camel@localhost.localdomain>
Date: Mon, 1 Aug 2005 16:23:18 -0500 (CDT)
Subject: Re: [patch] Support powering sharp zaurus sl-5500 LCD up and down
From: "John Lenz" <lenz@cs.wisc.edu>
To: "Richard Purdie" <rpurdie@rpsys.net>
Cc: "Pavel Machek" <pavel@ucw.cz>, "Andrew Morton" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, July 27, 2005 5:06 am, Richard Purdie said:
> On Wed, 2005-07-27 at 11:53 +0200, Pavel Machek wrote:
>> +	/* read comadj */
>> +#ifdef CONFIG_MACH_POODLE
>> +	comadj = 118;
>> +#else
>> +	comadj = 128;
>> +#endif
>
> Can you go back to the Sharp source and confirm that these values should
> be hardcoded in both the poodle and collie cases please? I know the
> sharpsl_param code can provide them but I can't remember exactly which
> models use which fields. I want to make sure this isn't a quick hack
> John made before sharpsl_param was written :).

No, those values were from the original sharp code...  at some point I was
going to investigate what values the sharpsl param stuff returned and see
if those worked.  If the sharpsl stuff works, then by all means use it.

John

