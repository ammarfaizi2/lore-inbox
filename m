Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314395AbSFYRzU>; Tue, 25 Jun 2002 13:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314396AbSFYRzT>; Tue, 25 Jun 2002 13:55:19 -0400
Received: from pieck.student.uva.nl ([146.50.96.22]:38558 "EHLO
	pieck.student.uva.nl") by vger.kernel.org with ESMTP
	id <S314395AbSFYRzS>; Tue, 25 Jun 2002 13:55:18 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rudmer van Dijk <rvandijk@science.uva.nl>
Reply-To: rvandijk@science.uva.nl
Organization: UvA
To: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.24-dj2
Date: Tue, 25 Jun 2002 19:58:43 +0200
X-Mailer: KMail [version 1.3.2]
References: <20020625163824.GA20888@suse.de>
In-Reply-To: <20020625163824.GA20888@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020625175518Z314395-22020+10471@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 June 2002 18:38, Dave Jones wrote:
> Just some small bits for now (other than 40kb of bits from 2.4),
> more stuff pending will probably wait until after I get back from
> KS/OLS/UKUUG conferences.

This is working great!
No more trouble with X (writing this mail with KMail in 2.5.24-dj2)

using these options:
CONFIG_PREEMPT=y
CONFIG_AGP=y
CONFIG_AGP_SIS=y
CONFIG_DRM=y
CONFIG_DRM_MGA=y

turned preemt on a long time ago and never noticed anymore since I use make 
oldconfig, so if there was any trouble with preempt in 23-dj it is fixed now

also the '__iounmap: bad address d0802030' message is gone thanks to Andi.

so it looks solid (at least for the 10 min it is running (seti@home) now)

	Rudmer
