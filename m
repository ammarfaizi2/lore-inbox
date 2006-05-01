Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWEAOVA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWEAOVA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 10:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbWEAOVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 10:21:00 -0400
Received: from nproxy.gmail.com ([64.233.182.185]:6680 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932105AbWEAOU7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 10:20:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=JCcWDGzvwECyjigltLtTMmCos2ryAwpUF1naGb3++SOraq3f8/CrnyRUkrUmItmgAosVro+kMJUyt9eT8gwiMSVA2VxnGKkLTQ1xfkTftYtWBO8rmnlLwlJKLPUOZY9ccTowAu98bplZmjYHE3kGUT3e185J66LdqUUWfRAi758=
Date: Mon, 1 May 2006 18:19:01 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] CodingStyle: add typedefs chapter
Message-ID: <20060501141901.GA7267@mipter.zuzino.mipt.ru>
References: <20060430174426.a21b4614.rdunlap@xenotime.net> <Pine.LNX.4.61.0605011559010.31804@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0605011559010.31804@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2006 at 04:00:09PM +0200, Jan Engelhardt wrote:
> >+Please don't use things like "vps_t".
> >+It's a _mistake_ to use typedef for structures and pointers. When you see a
> >+	vps_t a;
> >+in the source, what does it mean?
> >+In contrast, if it says
> >+	struct virtual_container *a;
> >+you can actually tell what "a" is.
> >+
> >+Lots of people think that typedefs "help readability". Not so. They are
> >+useful only for:
> [...]
>
> What about task_t vs struct task_struct? Both are used in the kernel.

task_t			=> struct task
struct task_struct	=> struct task

Roughly 2765 hits :-\

