Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261938AbUKCXKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbUKCXKh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 18:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbUKCXKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 18:10:12 -0500
Received: from brown.brainfood.com ([146.82.138.61]:21376 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S261938AbUKCXCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 18:02:22 -0500
Date: Wed, 3 Nov 2004 17:02:15 -0600 (CST)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.6.8
In-Reply-To: <20041103205121.0184a9c7@mango.fruits.de>
Message-ID: <Pine.LNX.4.58.0411031701520.1229@gradall.private.brainfood.com>
References: <OF9F489E60.B8B3EA93-ON86256F40.007C1401-86256F40.007C1430@raytheon.com>
 <20041103083900.GA27211@elte.hu> <20041103084217.GA27404@elte.hu>
 <20041103100053.GA32680@elte.hu> <20041103123935.GA7865@elte.hu>
 <20041103205121.0184a9c7@mango.fruits.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Nov 2004, Florian Schmidt wrote:

> i tried V0.7.7 ...

I can't use 0.7.7.  I have the known problem with ide+lvm.  Backing out
dio-handle-eof.patch fixes it for me, at least on 2.6.9-mm1.  Haven't tried
against 2.6.10-rc1-mm2(which is still broken).
