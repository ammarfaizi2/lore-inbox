Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261431AbRERSoL>; Fri, 18 May 2001 14:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261433AbRERSoB>; Fri, 18 May 2001 14:44:01 -0400
Received: from [206.14.214.140] ([206.14.214.140]:34062 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S261431AbRERSn5>; Fri, 18 May 2001 14:43:57 -0400
Date: Fri, 18 May 2001 11:43:49 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Felix von Leitner <leitner@convergence.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: problem: reading from (rivafb) framebuffer is really slow
In-Reply-To: <20010518032923.A17686@convergence.de>
Message-ID: <Pine.LNX.4.10.10105181142240.12643-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> When benchmarking DirectFB, I found that a typical software alpha
> blending rectangle fill is completely dominated (I'm talking 90% of the
> CPU cycles here) by the time it takes to read pixels from the
> framebuffer.

Note the SOFTWARE alpha blending rectangle fill. You are passing alot of
data over the bus. So slooooooooow. If you implement a accelerated
function you will not have this problem.

