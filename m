Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264111AbTDJRRe (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 13:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264109AbTDJRRe (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 13:17:34 -0400
Received: from hera.cwi.nl ([192.16.191.8]:54924 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S264108AbTDJRRb (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 13:17:31 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 10 Apr 2003 19:29:11 +0200 (MEST)
Message-Id: <UTC200304101729.h3AHTB426607.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, levon@movementarian.org
Subject: Re: [PATCH] kill two scsi ioctls
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    On Thu, Apr 10, 2003 at 06:33:26PM +0200, Andries.Brouwer@cwi.nl wrote:

    > The definition for SCSI_IOCTL_BENCHMARK_COMMAND was added in 1.1.2.
    > The definition for SCSI_IOCTL_SYNC was added in 1.1.38.
    > Neither of them has ever been used.

    Can't you at least add a comment about what was there ? It's quite
    annoying to come across :

    #define FOO 1
    #define BAR 2
    #define BAZ 5

    and have no idea why

It happens all the time. Hundreds of cases.

I prefer a short and clean actual kernel source, and long
historical explanations somewhere else, for example in
Documentation/ioctl_list.

(Michael Elizabeth Chastain made ioctl_list.2 a man page,
but nobody keeps it up-to-date. The current version is from
1.3.27. I am updating it and expect to submit it for the
Documentation directory. Maybe more people will update it there.)

Andries
