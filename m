Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965511AbWIRHGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965511AbWIRHGk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 03:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965512AbWIRHGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 03:06:40 -0400
Received: from mail.gmx.de ([213.165.64.20]:53177 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965511AbWIRHGk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 03:06:40 -0400
X-Authenticated: #14349625
Subject: Re: sluggish system with 2.6.17 and dm-crypt - PARTLY SOLVED
From: Mike Galbraith <efault@gmx.de>
To: Martin Kourim <martink@hkfree.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200609171422.46629.martink@hkfree.org>
References: <200609161053.20317.martink@hkfree.org>
	 <200609171422.46629.martink@hkfree.org>
Content-Type: text/plain
Date: Mon, 18 Sep 2006 09:18:13 +0000
Message-Id: <1158571093.6376.19.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-09-17 at 14:22 +0200, Martin Kourim wrote:
> Hi,
> 
> yesterday, I've send mail below to this list. Today I've noticed that on 
> 2.6.17, kjournald is running with nice level -5. On 2.6.16, kjournald is 
> running with nice level 0. I did "renice 0 `pgrep kjournald`" and it 
> have "solved" my problem.

How much cpu is kjournald using in both 16 and 17 kernels?

	-Mike

