Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264444AbTFKUjY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 16:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264372AbTFKUhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 16:37:10 -0400
Received: from zeke.inet.com ([199.171.211.198]:13452 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id S264477AbTFKU1W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 16:27:22 -0400
Message-ID: <3EE793DD.7080408@inet.com>
Date: Wed, 11 Jun 2003 15:41:01 -0500
From: Eli Carter <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: rob@landley.net
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] Documentation/SendingPatches [2 of 2].
References: <200306111618.10329.rob@landley.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:
> The bit about log rolling.
> 
> --- linux-new/Documentation/SubmittingPatches	2003-06-11 15:54:29.000000000 -0400
> +++ linux-new/Documentation/SubmittingPatches2	2003-06-11 15:54:06.000000000 -0400
> @@ -92,6 +92,16 @@
>  complete, that is OK.  Simply note "this patch depends on patch X"
>  in your patch description.
>  
> +In politics, there's a concept called "log rolling", where unrelated
> +amendments are bundled together so that changes people want grease the
> +way for changes they don't.  Do not do this.  It's annoying.
> +
> +In coding, this sort of thing can be very subtle, such as performance increases
> +that help your new version perform as well as the original while doing more
> +work, but which could also have been applied to the original making it even
> +faster.  The linux-kernel guys are very good at taking the chocolate coating
> +and leaving the pill behind.  This can be very frustrating to developers, but
> +it's one of the big reasons open source produces such excellent results.

They are also likely to tell _you_ to take the pill out, clean up the 
chocolate, and resubmit; and that takes more of _your_ time.

(And I do like that you broke the log rolling change out; very good 
object lesson. :) )

Eli
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------

