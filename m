Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263026AbVFWSw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263026AbVFWSw5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 14:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263033AbVFWSts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 14:49:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50602 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263029AbVFWSoY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 14:44:24 -0400
Date: Thu, 23 Jun 2005 11:43:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Mahoney <jeffm@suse.de>
Cc: penberg@gmail.com, reiser@namesys.com, ak@suse.de, flx@namesys.com,
       zam@namesys.com, vs@thebsh.namesys.com, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com, penberg@cs.helsinki.fi
Subject: Re: -mm -> 2.6.13 merge status
Message-Id: <20050623114318.5ae13514.akpm@osdl.org>
In-Reply-To: <42BB0151.3030904@suse.de>
References: <20050620235458.5b437274.akpm@osdl.org.suse.lists.linux.kernel>
	<p73d5qgc67h.fsf@verdi.suse.de>
	<42B86027.3090001@namesys.com>
	<20050621195642.GD14251@wotan.suse.de>
	<42B8C0FF.2010800@namesys.com>
	<84144f0205062223226d560e41@mail.gmail.com>
	<42BB0151.3030904@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Mahoney <jeffm@suse.de> wrote:
>
> >>+	assert("nikita-955", pool != NULL);
>  > 
>  > These assertion codes are meaningless to the rest of us so please drop
>  > them.
> 
>  As someone who spends time debugging reiser3 issues, I've grown
>  accustomed to the named assertions. They make discussing a particular
>  assertion much more natural in conversation than file:line.

__FUNCTION__?
