Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269026AbTBWWvD>; Sun, 23 Feb 2003 17:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269027AbTBWWvD>; Sun, 23 Feb 2003 17:51:03 -0500
Received: from dodge.jordet.nu ([217.13.8.142]:30615 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id <S269026AbTBWWvC>;
	Sun, 23 Feb 2003 17:51:02 -0500
Subject: Re: High load with 2.5.x
From: Stian Jordet <liste@jordet.nu>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030223215811.GJ10411@holomorphy.com>
References: <1046036480.29501.5.camel@chevrolet.hybel>
	 <20030223215811.GJ10411@holomorphy.com>
Content-Type: text/plain; charset=ISO-8859-1
Organization: 
Message-Id: <1046041270.687.6.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 24 Feb 2003 00:01:11 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

søn, 2003-02-23 kl. 22:58 skrev William Lee Irwin III:
> On Sun, Feb 23, 2003 at 10:41:21PM +0100, Stian Jordet wrote:
> > I have the last 2.5.x kernels experienced a high load while idle. 1.00
> > mostly. I have dual cpu, and it isn't really bothering me. But I do not
> > experience this with 2.4.x kernels. I do not remember when this started,
> > but since noone else complains, I just want to ask how can I find out
> > what is making my load so high?
> 
> top(1) should report cpu time consumers.

But it didn't. But as others have replied to me off-list, processes in D
state make the loadaverage high. My problem was [kIrDAd]. Compiling
kernel without irda actually solved several problems. So now I'm just
happy :) Thanks :)

Regards,
Stian

