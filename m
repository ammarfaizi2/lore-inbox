Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265515AbUAMUiP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 15:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265563AbUAMUiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 15:38:15 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:52429 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265515AbUAMUiC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 15:38:02 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 13 Jan 2004 12:38:05 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Jeff Dike <jdike@addtoit.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC] /dev/anon
In-Reply-To: <200401132021.i0DKLBhg002890@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.44.0401131236140.12810-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jan 2004, Jeff Dike wrote:

> UML has a need to free dirty pages in the middle of a file (which is described
> in more detail below).  The obvious way to do this, and one which has come up 
> before, is a sys_punch system call for making a hole in the middle of a file.

Now I'm going to say something really stupid, but why sys_madvise(MADV_DONTNEED)
won't work for this?



- Davide


