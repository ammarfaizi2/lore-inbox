Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264932AbTGCQRE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 12:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264943AbTGCQQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 12:16:44 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:647 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S264932AbTGCQN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 12:13:58 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] O1int 0307021808 for interactivity
Date: Thu, 3 Jul 2003 18:29:29 +0200
User-Agent: KMail/1.5.2
Cc: Andrew Morton <akpm@digeo.com>
References: <200307021823.56904.kernel@kolivas.org> <200307031627.11299.phillips@arcor.de> <200307040034.49102.kernel@kolivas.org>
In-Reply-To: <200307040034.49102.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307031829.29219.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 July 2003 16:34, Con Kolivas wrote:
> On Fri, 4 Jul 2003 00:27, Daniel Phillips wrote:
> > I'm still pretty much in the dark after that.  It says something about
> > your patch, but it doesn't say much about the problem you're solving,
> > i.e., what's the Context?  (pun intended)
>
> Basically? Who gets to preempt who and for how long. The interactivity
> estimator should decide that the correct task is interactive and get a
> dynamically higher priority and larger timeslice. Is this what you're
> asking?

I guess what I'm saying is, the problem is far from solved, however your 
concrete results demonstrate you've got an intuitive grasp of how to go at 
it.  I'd like to dig in and find out what the deep issues are.  As I've 
basically ignored scheduling up to now, including all of the details of 
Ingo's work, there's some background to fill in.  Being lazy, I'd prefer to 
read somebody's detailed [rfc] instead of going through the process of 
reverse engineering it myself.  I presume I'm not the only one.

Regards,

Daniel

