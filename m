Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272329AbRH3Qrn>; Thu, 30 Aug 2001 12:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272330AbRH3Qre>; Thu, 30 Aug 2001 12:47:34 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:53902 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S272329AbRH3QrT>; Thu, 30 Aug 2001 12:47:19 -0400
Date: Thu, 30 Aug 2001 12:47:36 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@toomuch.toronto.redhat.com>
To: Michael E Brown <michael_e_brown@dell.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blkgetsize64 ioctl
In-Reply-To: <Pine.LNX.4.33.0108301131070.1213-100000@blap.linuxdev.us.dell.com>
Message-ID: <Pine.LNX.4.33.0108301247130.12593-100000@toomuch.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2001, Michael E Brown wrote:

> And your last point about risking unexpected disk-io due to an incorrect
> IOCTL, I would say that is a pretty unlikely in practice. First, I do
> parameter checking on what was passed to the IOCTL, and if things don't
> match, no io is done. Second, how likely is it that you a) call ioctl with
> a (disk) block device, b) pass the wrong ioctl, c) pass along enough data
> to pass the checks in the ioctl, and d) pass along a valid pointer to 512
> bytes of data to overwrite something?

e2fsprogs-1.23 on x86 does this.

		-ben

