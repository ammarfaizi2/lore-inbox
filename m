Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318069AbSGWO2M>; Tue, 23 Jul 2002 10:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318071AbSGWO2M>; Tue, 23 Jul 2002 10:28:12 -0400
Received: from letterman.noris.net ([62.128.1.26]:37505 "EHLO
	letterman.noris.net") by vger.kernel.org with ESMTP
	id <S318069AbSGWO2M>; Tue, 23 Jul 2002 10:28:12 -0400
Mime-Version: 1.0
Message-Id: <p05111700b963180b03ed@[10.2.6.42]>
Date: Tue, 23 Jul 2002 16:31:04 +0200
To: linux-kernel@vger.kernel.org
From: Matthias Urlichs <smurf@noris.de>
Subject: Re: using bitkeeper to backport subsystems?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lars:
>   Larry McVoy <lm@bitmover.com> said:
>  > Thanks, we agree completely.  It's actually an impossible problem
>  > for a program since it requires semantic knowledge of the content
>  > under revision control.
>
>  So, another option would be to have the developer define explicit 
>dependencies
>  for his changesets, but I fear that might prove to cumbersome, too.
>
If you spend the effort to do _that_, you might as well clone your BK 
tree and prune it back to a state which conceivably has only the 
changes which you depend on.

Another problem with that approach, however, is that if everybody 
does it then the kernel's version tree, as evident in "bk revtool", 
gets totally unreadable. It is already an order of magnitude too 
complicated.  :-(

-- 
Matthias Urlichs
