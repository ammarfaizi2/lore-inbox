Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262076AbVBARD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbVBARD0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 12:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbVBARBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 12:01:37 -0500
Received: from [195.23.16.24] ([195.23.16.24]:44214 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262072AbVBARBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 12:01:23 -0500
Message-ID: <41FFB5A1.20100@grupopie.com>
Date: Tue, 01 Feb 2005 17:00:17 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pekka Enberg <penberg@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] 1/7 create kstrdup library function
References: <1107228501.41fef755e66e8@webmail.grupopie.com> <84144f0205020108441679cbef@mail.gmail.com>
In-Reply-To: <84144f0205020108441679cbef@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:
> [...]
> 
> kstrdup() is a special-case _memory allocator_ (not so much a string
> operation) so I think it should go into mm/slab.c where we currently
> have kcalloc().

I was following Rusty Russell's approach. Also, I believe this is more 
intuitive because the standard libc strdup function is declared in string.h.

However, I really don't have strong feelings either way, so if the 
majority agrees that this should be in mm/slab, its fine by me.

> P.S. Please inline patches to your email as per
> Documentation/SubmittingPatches. I, for one, have trouble with
> attachments.

Unfortunately my email client messes up inline patches and wordwraps / 
mangles white space, so I resort to attaching them until I have time to 
look into fixing that :(

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
