Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129679AbRCAQIf>; Thu, 1 Mar 2001 11:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129686AbRCAQIZ>; Thu, 1 Mar 2001 11:08:25 -0500
Received: from [199.183.24.200] ([199.183.24.200]:53885 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129679AbRCAQIV>; Thu, 1 Mar 2001 11:08:21 -0500
Date: Thu, 1 Mar 2001 11:08:13 -0500 (EST)
From: Ben LaHaise <bcrl@redhat.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Martin Rauh <martin.rauh@gmx.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Writing on raw device with software RAID 0 is slow
In-Reply-To: <20010301160201.P26280@redhat.com>
Message-ID: <Pine.LNX.4.30.0103011106540.13184-100000@today.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Mar 2001, Stephen C. Tweedie wrote:

> Yep.  There shouldn't be any problem increasing the 64KB size, it's
> only the lack of accounting for the pinned memory which stopped me
> increasing it by default.

Actually, how about making it a sysctl?  That's probably the most
reasonable approach for now since the optimal size depends on hardware.

		-ben

