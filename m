Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282805AbRLTGvX>; Thu, 20 Dec 2001 01:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284258AbRLTGvN>; Thu, 20 Dec 2001 01:51:13 -0500
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:1153 "EHLO
	phalynx") by vger.kernel.org with ESMTP id <S282805AbRLTGu7>;
	Thu, 20 Dec 2001 01:50:59 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ryan Cumming <bodnar42@phalynx.dhs.org>
To: timothy.covell@ashavan.org
Subject: Re: Scheduler, Can we save some juice ...
Date: Wed, 19 Dec 2001 22:50:54 -0800
X-Mailer: KMail [version 1.3.2]
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0112200149330.15741-100000@imladris.surriel.com> <200112200637.fBK6b2Sr014173@svr3.applink.net>
In-Reply-To: <200112200637.fBK6b2Sr014173@svr3.applink.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Gx2c-0000GY-00@phalynx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 19, 2001 22:33, Timothy Covell wrote:
> OK, here's another 0.1% for you.  Considering how Linux SMP
> doesn't have high CPU affinity, would it be possible to make a
> patch such that the additional CPUs remain in deep sleep/HALT
> mode until the first CPU hits a high-water mark of say 90%
> utilization?  I've started doing this by hand with the (x)pulse
> application.   My goal is to save electricity and cut down on
> excess heat when I'm just browsing the web and not compiling
> or seti@home'ing.

I seriously doubt there would be a noticable power consumption or heat 
difference between two CPU's running HLT half the time, and one CPU running 
HLT all the time. And I'm downright certain it isn't worth the code 
complexity even if it was, there is very little (read: no) intersection 
between the SMP and low-power user base.

-Ryan
