Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264450AbTDXVvH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 17:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264459AbTDXVvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 17:51:07 -0400
Received: from mx12.arcor-online.net ([151.189.8.88]:19337 "EHLO
	mx12.arcor-online.net") by vger.kernel.org with ESMTP
	id S264450AbTDXVvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 17:51:06 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Jamie Lokier <jamie@shareable.org>
Subject: Re: gettimeofday running backwards on 2.4.20
Date: Fri, 25 Apr 2003 00:04:33 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Trammell Hudson <hudson@osresearch.net>, linux-kernel@vger.kernel.org
References: <20030422232316.GF20108@osbox.osresearch.net> <20030424193410.C52BF12F067@mx12.arcor-online.net> <20030424214100.GL30082@mail.jlokier.co.uk>
In-Reply-To: <20030424214100.GL30082@mail.jlokier.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20030424220313.C279C12C4AD@mx12.arcor-online.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 24 Apr 03 23:41, Jamie Lokier wrote:
> Daniel Phillips wrote:
> > Applications like games (but not only games) can get pretty messed up by
> > a timeofday that jumps backwards every couple of seconds.
>
> It's a foolish game that doesn't implement your monotonicity algorithm
> itself...

Maybe so, but on the other hand, game authors could, with some justification, 
accuse kernel developers of being the foolish ones.

There is already code in there that is supposed to fix up the timer: it 
doesn't work very well.

I wonder if SUS or whatnot has anything to say about gettimeofday being 
monotonic, so long as the user does not change the time.

Regards,

Daniel
