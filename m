Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288958AbSBSTJV>; Tue, 19 Feb 2002 14:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288967AbSBSTJL>; Tue, 19 Feb 2002 14:09:11 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:7144 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S288960AbSBSTI6>; Tue, 19 Feb 2002 14:08:58 -0500
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.org>
To: cschumpf@gmx.net, linux-kernel@vger.kernel.org
Subject: Re: Patch or module?
Date: Tue, 19 Feb 2002 20:08:32 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <18920.1014143039@www57.gmx.net>
In-Reply-To: <18920.1014143039@www57.gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <16dFd0-1wqRZwC@fmrl09.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 February 2002 19:23, cschumpf@gmx.net wrote:
> If thats not the right group to discuss that, please let me know.
>
> I would like to write an IO-Bandwidth-Limiter on per Process and per
> User-Basis for a few disk drives. I can either patch the kernel functions
> read/write and enhance the task- and user-structure and globally check if
> the correct devices are adressed or I can write my own module, twist
> pointers from the filesystems on the drives and store the information about
> users and tasks there.

You cannot do this on the device level as the writing task is not identical
to the task actual having caused the requirement to do IO.

	HTH
		Oliver
