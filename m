Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268990AbTBWXQ0>; Sun, 23 Feb 2003 18:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269008AbTBWXQ0>; Sun, 23 Feb 2003 18:16:26 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:16907 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S268990AbTBWXQ0>; Sun, 23 Feb 2003 18:16:26 -0500
Date: Sun, 23 Feb 2003 18:23:01 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Gerrit Huizenga <gh@us.ibm.com>
cc: lse-tech@lists.sf.et,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Minutes from Feb 21 LSE Call 
In-Reply-To: <E18mhJw-0004I0-00@w-gerrit2>
Message-ID: <Pine.LNX.3.96.1030223181400.999D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Feb 2003, Gerrit Huizenga wrote:

> On 22 Feb 2003 18:20:19 GMT, Alan Cox wrote:
> > I think people overestimate the numbner of large boxes badly. Several IDE
> > pre-patches didn't work on highmem boxes. It took *ages* for people to
> > actually notice there was a problem. The desktop world is still 128-256Mb
> 
> IDE on big boxes?  Is that crack I smell burning?  A desktop with 4 GB
> is a fun toy, but bigger than *I* need, even for development purposes.
> But I don't think EMC, Clariion (low end EMC), Shark, etc. have any
> IDE products for my 8-proc 16 GB machine...  And running pre-patches in
> a production environment that might expose this would be a little
> silly as well.

I don't disagree with most of your point, however there certainly are
legitimate uses for big boxes with small (IDE) disk. Those which first
come to mind are all computational problems, in which a small dataset is
read from disk and then processors beat on the data. More or less common
examples are graphics transformations (original and final data
compressed), engineering calculations such as finite element analysis,
rendering (raytracing) type calculations, and data analysis (things like
setiathome or automated medical image analysis).

IDE drives are very cost effective, and low cost motherboard RAID is
certainly useful for preserving the results of large calculations on small
(relatively) datasets.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

