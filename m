Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314479AbSDRW1v>; Thu, 18 Apr 2002 18:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314481AbSDRW1u>; Thu, 18 Apr 2002 18:27:50 -0400
Received: from zero.tech9.net ([209.61.188.187]:51467 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S314479AbSDRW1t>;
	Thu, 18 Apr 2002 18:27:49 -0400
Subject: Re: [PATCH] migration thread fix
From: Robert Love <rml@tech9.net>
To: Anton Blanchard <anton@samba.org>
Cc: William Lee Irwin III <wli@holomorphy.com>,
        Erich Focht <efocht@ess.nec.de>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@elte.hu>, torvalds@transmeta.com
In-Reply-To: <20020418220743.GB13756@krispykreme>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 18 Apr 2002 18:27:48 -0400
Message-Id: <1019168869.5410.117.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-04-18 at 18:07, Anton Blanchard wrote:
> > I am also curious what causes #1 you mention.  Do you see it in the
> > _normal_ code or just with your patch?  
> 
> We were getting lockups with 2.5.5ish on the 32 way which #1 fixed.

You were getting lockups even on top of your TASK_INTERRUPTIBLE fix
(which was post-2.5.5)?  The migration code sure is delicate...

	Robert Love

