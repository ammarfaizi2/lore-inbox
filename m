Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbUC1MTF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 07:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbUC1MTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 07:19:05 -0500
Received: from mail.shareable.org ([81.29.64.88]:49810 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261568AbUC1MTB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 07:19:01 -0500
Date: Sun, 28 Mar 2004 13:16:40 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Peter Williams <peterw@aurema.com>
Cc: Micha Feigin <michf@post.tau.ac.il>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: finding out the value of HZ from userspace
Message-ID: <20040328121640.GA32296@mail.shareable.org>
References: <20040316063331.GB23988@devserv.devel.redhat.com> <40578FDB.9060000@aurema.com> <20040320102241.GK2803@devserv.devel.redhat.com> <405C2AC0.70605@stesmi.com> <20040322223456.GB2549@luna.mooo.com> <405F70F6.5050605@aurema.com> <20040325174053.GB11236@mail.shareable.org> <406369A1.7090905@aurema.com> <20040327133133.GB21884@mail.shareable.org> <406613BC.90602@aurema.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <406613BC.90602@aurema.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> >>Making HZ == USER_HZ would also solve the problem.
> >
> >Making them equal now would reintroduce the problem that USER_HZ was
> >created to resolve: some userspace programs hard-code the value, so it
> >cannot be changed in interfaces used by those programs.
> 
> That was the wrong solution to that particular problem.  The programs 
> should have been fixed rather than the kernel being maimed to 
> accommodate their shortcomings.

I agree, and perhaps that should still be done so we can eliminate USER_HZ.

-- Jamie
