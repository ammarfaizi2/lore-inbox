Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbVC0MqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbVC0MqD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 07:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbVC0MqC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 07:46:02 -0500
Received: from simmts12.bellnexxia.net ([206.47.199.141]:52698 "EHLO
	simmts12-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261628AbVC0Mpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 07:45:45 -0500
Message-ID: <1824.10.10.10.24.1111927362.squirrel@linux1>
In-Reply-To: <Pine.LNX.4.10.10503261710320.13484-100000@mtfhpc.demon.co.uk>
References: <Pine.LNX.4.10.10503261710320.13484-100000@mtfhpc.demon.co.uk>
Date: Sun, 27 Mar 2005 07:42:42 -0500 (EST)
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
From: "Sean" <seanlkml@sympatico.ca>
To: "Mark Fortescue" <mark@mtfhpc.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.4-2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, March 26, 2005 12:52 pm, Mark Fortescue said:
> Hi,
>
> I am writing a "Proprietry" driver module for a "Proprietry" PCI card and
> I have found that I can't use SYSFS on Linux-2.6.10.
>
> Why ?.

Because the people that contributed the code you want to use said so.

> I am not modifing the Kernel/SYSFS code so I should be able, to use all
> the SYSFS/internal kernel function calls without hinderence.

You're creating a derived work that could not exist without all the GPL
code that came before.

> In order to be able to use SYSFS to debug the driver during development
> the way I would like to be able to do, I will have to temporally change
> the module licence line to "GPL". When the development is finnished I
> then need to remove all the code that accesses the SYSFS stuf in the
> Kernel and change the module back to a "Proprietry" licence in order to
> comply with other requirements. This will then hinder any debugging if
> future issues arise.

Likely this won't be enough to keep you or your company from being sued.

> I believe that this sort of idiocy is what helps Microsoft hold on to its
> manopoly and as shuch hinders hardware/software development in all areas
> and should be chanaged in a way that promotes diversified software
> development.

So what?   The people that created the kernel GPL code weren't necessarily
trying to topple microsoft.   In essense, all they said was they were
willing to share their code with people who were also willing to share.  
You're probably better off writing your proprietary driver on a
proprietary operating system.

Sean


