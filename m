Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318866AbSICSNq>; Tue, 3 Sep 2002 14:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318869AbSICSNq>; Tue, 3 Sep 2002 14:13:46 -0400
Received: from dsl-213-023-043-116.arcor-ip.net ([213.23.43.116]:29333 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318866AbSICSNp>;
	Tue, 3 Sep 2002 14:13:45 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: ptb@it.uc3m.es, Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [RFC] mount flag "direct"
Date: Tue, 3 Sep 2002 20:20:20 +0200
X-Mailer: KMail [version 1.3.2]
Cc: "Peter T. Breuer" <ptb@it.uc3m.es>,
       linux kernel <linux-kernel@vger.kernel.org>
References: <200209031544.g83FiAG03134@oboe.it.uc3m.es>
In-Reply-To: <200209031544.g83FiAG03134@oboe.it.uc3m.es>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17mIHk-0005iv-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 September 2002 17:44, Peter T. Breuer wrote:
> > > Scenario:
> > > I have a driver which accesses a "disk" at the block level, to which
> > > another driver on another machine is also writing. I want to have
> > > an arbitrary FS on this device which can be read from and written to
> > > from both kernels, and I want support at the block level for this idea.
> > 
> > You cannot have an arbitrary fs. The two fs drivers must coordinate with
> > each other in order for your scheme to work. Just think about if the two 
> > fs drivers work on the same file simultaneously and both start growing the
> > file at the same time. All hell would break lose.
> 
> Thanks!
> 
> Rik also mentioned that objection! That's good. You both "only" see
> the same problem, so there can't be many more like it..

(intentionally misinterpreting)  No indeed, there are aren't many problems
like it, in terms of sheer complexity.

-- 
Daniel
