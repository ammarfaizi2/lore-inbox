Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264313AbTIJOW0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 10:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264330AbTIJOW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 10:22:26 -0400
Received: from gprs147-217.eurotel.cz ([160.218.147.217]:31873 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S264313AbTIJOWV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 10:22:21 -0400
Date: Wed, 10 Sep 2003 16:20:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dave Jones <davej@redhat.com>, Mitchell Blank Jr <mitch@sfgoth.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] oops_in_progress is unlikely()
Message-ID: <20030910142031.GB2589@elf.ucw.cz>
References: <20030907064204.GA31968@sfgoth.com> <20030907221323.GC28927@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030907221323.GC28927@redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  > Andrew - thanks for applying my last patch; thought you might be interested
>  > in this trivial one too.  Patch is versus 2.6.0-test4-bk8, I expect it
>  > will also apply against current -mm.
> 
> none of this patch seems to touch particularly performance critical code.
> Is it really worth adding these macros to every if statement in the kernel?
> There comes a point where readability is lost, for no measurable gain.

Perhaps we should have macros ifu() and ifl(), that would be used as a
plain if, just with likelyness-indication? That way we could have it
in *every* statement and readability would not suffer that much...

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
