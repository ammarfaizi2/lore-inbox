Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751045AbWEZQ0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbWEZQ0d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 12:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbWEZQ0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 12:26:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29865 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750704AbWEZQ0c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 12:26:32 -0400
Date: Fri, 26 May 2006 09:25:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, wfg@mail.ustc.edu.cn, mstone@mathom.us
Subject: Re: [PATCH 00/33] Adaptive read-ahead V12
Message-Id: <20060526092544.3ef26e8a.akpm@osdl.org>
In-Reply-To: <p73irns7uoh.fsf@bragg.suse.de>
References: <348469535.17438@ustc.edu.cn>
	<20060525084415.3a23e466.akpm@osdl.org>
	<p73irns7uoh.fsf@bragg.suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> Andrew Morton <akpm@osdl.org> writes:
> > 
> > These are nice-looking numbers, but one wonders.  If optimising readahead
> > makes this much difference to postgresql performance then postgresql should
> > be doing the readahead itself, rather than relying upon the kernel's
> > ability to guess what the application will be doing in the future.  Because
> > surely the database can do a better job of that than the kernel.
> 
> With that argument we should remove all readahead from the kernel? 
> Because it's already trying to guess what the application will do. 
> 
> I suspect it's better to have good readahead code in the kernel
> than in a zillion application.
> 

Wu: "this readahead patch speeds up postgres"

Me: "but postgres could be sped up even more via X"

everyone: "ah, you're saying that's a reason for not altering readahead!".


Would everyone *please* stop being so completely and utterly thick?

Thank you.
