Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbVL3Uwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbVL3Uwh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 15:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbVL3Uwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 15:52:37 -0500
Received: from [212.76.84.69] ([212.76.84.69]:30470 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1750911AbVL3Uwg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 15:52:36 -0500
From: Al Boldi <a1426z@gawab.com>
To: "Barry K. Nathan" <barryn@pobox.com>
Subject: Re: [PATCH] strict VM overcommit accounting for 2.4.32/2.4.33-pre1
Date: Fri, 30 Dec 2005 23:51:58 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200512302306.28667.a1426z@gawab.com> <986ed62e0512301218v30dd5d67m699bf7c29375a1fe@mail.gmail.com>
In-Reply-To: <986ed62e0512301218v30dd5d67m699bf7c29375a1fe@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512302351.58650.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Barry K. Nathan wrote:
> On 12/30/05, Al Boldi <a1426z@gawab.com> wrote:
> > Thanks a lot!
> >
> > > +3 - (NEW) paranoid overcommit The total address space commit
> > > +      for the system is not permitted to exceed swap. The machine
> > > +      will never kill a process accessing pages it has mapped
> > > +      except due to a bug (ie report it!)
> >
> > This one isn't in 2.6, which is critical for a stable system.
>
> I think you can get paranoid overcommit with either my patch or 2.6 by
> setting /proc/sys/vm/overcommit_mode to 2 *and*
> /proc/sys/vm/overcommit_ratio to 0, however.

Not really in 2.6.
And even if this were made to work, what would it imply to a system running 
w/o swap?

Thanks!

--
Al

