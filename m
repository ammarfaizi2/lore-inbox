Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267923AbRHFLDw>; Mon, 6 Aug 2001 07:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267933AbRHFLDn>; Mon, 6 Aug 2001 07:03:43 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:25947 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S267923AbRHFLDa>; Mon, 6 Aug 2001 07:03:30 -0400
To: Abraham vd Merwe <abraham@2d3d.co.za>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Felix von Leitner <leitner@fefe.de>
Subject: Re: kernel headers & userland
In-Reply-To: <20010806095638.A5638@crystal.2d3d.co.za>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 06 Aug 2001 04:56:49 -0600
In-Reply-To: <20010806095638.A5638@crystal.2d3d.co.za>
Message-ID: <m166c1wj66.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Abraham vd Merwe <abraham@2d3d.co.za> writes:

> Hi!
> 
> Apparently Linus told Felix von Leitner (the author of dietlibc - a small,
> no nonsense glibc replacement C library) a while ago _not_ to include any
> linux kernel headers in userland (i.e. the C library headers in this case).
> 
> This imho is obviously wrong since there are definitely a need for including
> kernel headers on a linux platform.

???  Necessity no.  Are there practical benefits yes.

The policy of the kernel developers in general is that if your apps
includes kernel headers and it breaks, it is a kernel problem.

As for ioctl it is a giant mess that needs to be taken out and shot.

And yes there are places where even the mighty glibc is in the wrong.

Eric
