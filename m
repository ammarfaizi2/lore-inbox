Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289191AbSBJCDy>; Sat, 9 Feb 2002 21:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289185AbSBJCDf>; Sat, 9 Feb 2002 21:03:35 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:50009 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S289172AbSBJCDa>; Sat, 9 Feb 2002 21:03:30 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200202100203.g1A23To32387@devserv.devel.redhat.com>
Subject: Re: [V4L] [PATCH/RFC] videodev.[ch] redesign
To: video4linux-list@redhat.com
Date: Sat, 9 Feb 2002 21:03:29 -0500 (EST)
Cc: linux-kernel@vger.kernel.org (Kernel List)
In-Reply-To: <20020209194602.A23061@bytesex.org> from "Gerd Knorr" at Feb 09, 2002 07:46:02 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It also provides a ioctl wrapper function which handles copying the
> ioctl args from/to userspace, so we have this at one place can drop all
> the copy_from/to_user calls within the v4l device driver ioctl handlers.
> 
> Comments?

I'm not sure 2.4 should change but for 2.5 this is absolutely bang on
perfect
