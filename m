Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWDENyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWDENyR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 09:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbWDENyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 09:54:17 -0400
Received: from wildsau.enemy.org ([193.170.194.34]:8075 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S1750716AbWDENyR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 09:54:17 -0400
From: Herbert Rosmanith <kernel@wildsau.enemy.org>
Message-Id: <200604051350.k35DoIXF009872@wildsau.enemy.org>
Subject: Re: Q on audit, audit-syscall
In-Reply-To: <0CC157BB-7180-4B94-817A-E96A6099FBA6@mac.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Date: Wed, 5 Apr 2006 15:50:17 +0200 (MET DST)
CC: Robin Holt <holt@sgi.com>, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Apr 5, 2006, at 08:06:30, Herbert Rosmanith wrote:
> >> On Wed, Apr 05, 2006 at 01:27:03PM +0200, Herbert Rosmanith wrote:
> >>>
> >>> good afternoon,
> >>>
> >>> I'm searching for a way to trace/intercept syscalls, both before  
> >>> and after execution. "ptrace" is not an option (you probably know  
> >>> why).
> >>
> >> Does strace do what you are asking for?
> >
> > as I said, "ptrace" is not an option.
> 
> Why not, exactly?  (No, we don't know why).

according to the man-page:

RETURN VALUES
     EPERM   The specified process [...] is already being traced.

this makes it unusable for me.

>  ptrace is _the_ Linux  mechanism to trace and intercept syscalls.
>
> There is no other way.

"there is no other way": [1,2,3,4]

regards,
h.rosmanith

[1] http://www.uniforum.chi.il.us/slides/HardeningLinux/LAuS-Design.pdf
[2] http://www.usenix.org/publications/library/proceedings/als01/full_papers/edwards/edwards.pdf
[3] http://www.citi.umich.edu/u/provos/papers/systrace.pdf
[4] http://www.nsa.gov/selinux/papers/freenix01.pdf
