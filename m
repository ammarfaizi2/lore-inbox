Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310203AbSCHIZ0>; Fri, 8 Mar 2002 03:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310733AbSCHIZO>; Fri, 8 Mar 2002 03:25:14 -0500
Received: from pc3-camc5-0-cust13.cam.cable.ntl.com ([80.4.125.13]:28380 "EHLO
	fenrus.demon.nl") by vger.kernel.org with ESMTP id <S310203AbSCHIZJ>;
	Fri, 8 Mar 2002 03:25:09 -0500
Date: Fri, 8 Mar 2002 08:23:12 GMT
Message-Id: <200203080823.g288NC514338@fenrus.demon.nl>
From: arjan@fenrus.demon.nl
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Submitting PROMISE IDE Controllers Driver Patch
In-Reply-To: <3C88742A.4090804@evision-ventures.com>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.9-21 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3C88742A.4090804@evision-ventures.com> you wrote:
> Uhh oh, that's actually interresting and you are right on this point.
> One should just add the functionality. If you dare to wait the weekend
> it will happen in 2.5 ;-). Or of you care your self, then plase
> have a look at the following code in 2.5.6-pre3 in ide-pci:

Ehm. Linux *needs* to see the controller as IDE controller in order to
support the raid. see pdcraid.c. It layers on top of the IDE layer
to operate.
