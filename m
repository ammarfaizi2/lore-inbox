Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbTEVAZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 20:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262412AbTEVAZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 20:25:58 -0400
Received: from imladris.surriel.com ([66.92.77.98]:13708 "EHLO
	imladris.surriel.com") by vger.kernel.org with ESMTP
	id S262410AbTEVAZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 20:25:57 -0400
Date: Wed, 21 May 2003 20:38:56 -0400 (EDT)
From: Rik van Riel <riel@imladris.surriel.com>
To: Mike Galbraith <efault@gmx.de>
cc: davidm@hpl.hp.com, "" <linux-kernel@vger.kernel.org>,
       "" <linux-ia64@linuxia64.org>
Subject: Re: web page on O(1) scheduler
In-Reply-To: <5.2.0.9.2.20030521111037.01ed0d58@pop.gmx.net>
Message-ID: <Pine.LNX.4.50L.0305212038120.5425-100000@imladris.surriel.com>
References: <5.2.0.9.2.20030521111037.01ed0d58@pop.gmx.net>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 May 2003, Mike Galbraith wrote:
> At 11:49 PM 5/20/2003 -0700, David Mosberger wrote:
> >Recently, I started to look into some odd performance behaviors of the
> >O(1) scheduler.  I decided to document what I found in a web page
> >at:
> >
> >         http://www.hpl.hp.com/research/linux/kernel/o1.php
>
> The page mentions persistent starvation.  My own explorations of this
> issue indicate that the primary source is always selecting the highest
> priority queue.

It's deeper than that.  The O(1) scheduler doesn't consider
actual CPU usage as a factor of CPU priority.


Rik
-- 
Engineers don't grow up, they grow sideways.
http://www.surriel.com/		http://kernelnewbies.org/
