Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131339AbRADVyC>; Thu, 4 Jan 2001 16:54:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131325AbRADVxw>; Thu, 4 Jan 2001 16:53:52 -0500
Received: from miranda.org ([209.58.150.153]:62733 "HELO miranda.org")
	by vger.kernel.org with SMTP id <S129830AbRADVxj>;
	Thu, 4 Jan 2001 16:53:39 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14932.61666.121251.62489@light.alephnull.com>
Date: Thu, 4 Jan 2001 16:53:38 -0500 (EST)
From: Rik Faith <faith@valinux.com>
To: Keith Whitwell <keithw@valinux.com>
Cc: DRI Development <dri-devel@lists.sourceforge.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Dri-devel] DRM patch for Linux 2.4.0-prerelease
In-Reply-To: [Keith Whitwell <keithw@valinux.com>] Thu  4 Jan 2001 14:27:22 -0700
In-Reply-To: <14932.51363.118932.987520@light.alephnull.com>
	<3A54EABA.EB3FBF7C@valinux.com>
X-Mailer: VM 6.72; XEmacs 21.1; Linux 2.4.0-test12 (light)
X-Pgp-Key: FB4753BD; 26 A0 3C 88 57 FA 19 D2  90 B3 60 60 97 C0 20 47
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu  4 Jan 2001 14:27:22 -0700,
   Keith Whitwell <keithw@valinux.com> wrote:
> It looks like this patch goes further than syncing with xfree 4.0.2,
> but syncs with the dri trunk instead.  There has been a version bump
> in the mga drm module on the dri trunk to add a 'blit' ioctl.  XFree
> 4.0.2 will barf on this.

You are correct.

For anyone using XFree86 4.0.2 or tracking what we'd like to be included
in Linux 2.4.0, please ignore all the drivers/char/drm/mga* diffs in the
last patch that I sent.  Ignoring those diffs will provide compatibility
with XFree86 4.0.2 for the MGA driver.

Sorry for the confusion.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
