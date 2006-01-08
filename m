Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932733AbWAHSWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932733AbWAHSWM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 13:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932742AbWAHSWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 13:22:11 -0500
Received: from [139.30.44.16] ([139.30.44.16]:40270 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S932733AbWAHSWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 13:22:01 -0500
Date: Sun, 8 Jan 2006 19:22:00 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [PATCH 2/4] capable/capability.h (fs/)
In-Reply-To: <20060107215115.7e6cb2a2.rdunlap@xenotime.net>
Message-ID: <Pine.LNX.4.63.0601081915580.6962@gockel.physik3.uni-rostock.de>
References: <20060107215115.7e6cb2a2.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Jan 2006, Randy.Dunlap wrote:

> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> fs: Use <linux/capability.h> where capable() is used.

Acked-by: Tim Schmielau <tim@physik3.uni-rostock.de>

Note that sched.h, which currently holds capable(), already includes 
<linux/capability.h>. So these patches are completely optional.

Still I do appreciate these patches, since they reduce the amount of work 
I need to do when removing unnecessary sched.h includes. :-)

Tim
