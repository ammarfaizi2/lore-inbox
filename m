Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965128AbWEKGkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965128AbWEKGkT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 02:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965155AbWEKGkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 02:40:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19615 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965128AbWEKGkS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 02:40:18 -0400
Date: Wed, 10 May 2006 23:37:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Diego Calleja <diegocg@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Update/kill Documentation/sysctl/* docs?
Message-Id: <20060510233728.5c27cc43.akpm@osdl.org>
In-Reply-To: <20060509004837.d542d2d8.diegocg@gmail.com>
References: <20060509004837.d542d2d8.diegocg@gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego Calleja <diegocg@gmail.com> wrote:
>
> In http://bugzilla.kernel.org/show_bug.cgi?id=6145 you asked to update
>  the sysctl docs. I've updated them and added/deleted the neccesary
>  stuff (except the ones that I don't know what on earth are they doing
>  because they're not...documented).

OK..

> However it looks like there's
>  duplication - Documentation/filesystems/proc.txt seems to document all
>  that aswell (but in a single doc, which makes it a bit unreadable 
>  for such big document, IMO)

Yes, the duplication is silly and wasteful and error-inducing.

>  What should be the best step? Kill Documentation/sysctl/ and keep 
>  filesystems/proc.txt updated and maybe split it in several files
>  to make it more readable? Update it but maintain in sync with
>  filesystems/proc.txt? delete proc.txt and keep sysctl/ updated...?

I'd have thought that keeping everything in Documentation/sysctl/*.txt and
killing proc.txt would be the best approach?

But I haven't looked into it much.  You have - what approach are you
recommending?
