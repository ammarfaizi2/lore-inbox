Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751374AbWC1INb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbWC1INb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 03:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWC1INb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 03:13:31 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:2834 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751374AbWC1INa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 03:13:30 -0500
Date: Tue, 28 Mar 2006 09:13:24 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Greg Lee <glee@swspec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: HZ != 1000 causes problem with serial device shown by git-bisect
Message-ID: <20060328081324.GA15222@flint.arm.linux.org.uk>
Mail-Followup-To: Greg Lee <glee@swspec.com>, linux-kernel@vger.kernel.org
References: <0e6601c651f8$9d253b40$a100a8c0@casabyte.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e6601c651f8$9d253b40$a100a8c0@casabyte.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2006 at 06:46:02PM -0500, Greg Lee wrote:
> I have also tried a number of other kernels and the problem exists all
> the way to 2.6.15.6 but is fixed in 2.6.16, so I am going to git-bisect
> 2.6.15.6 to 2.6.16, but I thought I would get this message out now in
> case someone has an inkling of what the problem is.

Saying that the problem is between 2.6.15.6 and 2.6.16 is rather
meaningless because you're effectively omitting _all_ the development
work between 2.6.15 to 2.6.16, and that's likely where the problem
lies.  Hence, you're omitting all the 2.6.16-rc kernels from your
testing.

> Please cc me on any responses.  Russell I copied you directly since I
> think you may be in the best position to understand the problem.

I have no ideas at the moment.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
