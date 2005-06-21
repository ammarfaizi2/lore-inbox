Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262225AbVFUSpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbVFUSpQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 14:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbVFUSpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 14:45:15 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:5581 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S262225AbVFUSpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 14:45:09 -0400
Message-ID: <42B86027.3090001@namesys.com>
Date: Tue, 21 Jun 2005 11:44:55 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>, Alexander Zarochentcev <zam@namesys.com>,
       vs <vs@thebsh.namesys.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status
References: <20050620235458.5b437274.akpm@osdl.org.suse.lists.linux.kernel> <p73d5qgc67h.fsf@verdi.suse.de>
In-Reply-To: <p73d5qgc67h.fsf@verdi.suse.de>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vs and zam, please comment on what we get from our profiler and spinlock
debugger that the standard tools don't supply.  I am sure you have a
reason, but now is the time to articulate it.

We would like to keep the disabled code in there until we have a chance
to prove (or fail to prove) that cycle detection can be resolved
effectively, and then with a solution in hand argue its merits.

Hans

Andi Kleen wrote:

> Also I'm not sure things like comming with an own profiler
>
>and spinlock debugger are really acceptable. At least this stuff
>should be removed too.
>
>-Andi
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>

