Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263139AbSJBPoX>; Wed, 2 Oct 2002 11:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263140AbSJBPoX>; Wed, 2 Oct 2002 11:44:23 -0400
Received: from mail.zedat.fu-berlin.de ([130.133.1.48]:5694 "EHLO
	Mail.ZEDAT.FU-Berlin.DE") by vger.kernel.org with ESMTP
	id <S263139AbSJBPoW>; Wed, 2 Oct 2002 11:44:22 -0400
Message-Id: <m17wlku-006fgaC@Mail.ZEDAT.FU-Berlin.DE>
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: David Brownell <david-b@pacbell.net>, Tommi Kyntola <kynde@ts.ray.fi>
Subject: Re: USB Mass Storage Hangs
Date: Wed, 2 Oct 2002 16:26:00 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0209301239330.8153-100000@behemoth.ts.ray.fi> <3D9910C1.2070301@pacbell.net>
In-Reply-To: <3D9910C1.2070301@pacbell.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 October 2002 05:04, David Brownell wrote:
> > Actually I did see those posts, it's just that I've had the exact same
> > problem on uhci and ohci, and because rmmod usb-storage between
> > unplug and plugin avoided the problem, I figured it was solely
> > usb-storage related.
>
> Ah, that wasn't clear to me from your post.  There are some issues
> to be dealt with still ... usb-storage error handling has to do the
> scsi_eh dance, but its choreography is problematic.

In principle scsi error handling can be overridden.
Whether this is worth it, is another question.

	Regards
		Oliver
