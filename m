Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267389AbTAVIpe>; Wed, 22 Jan 2003 03:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267390AbTAVIpd>; Wed, 22 Jan 2003 03:45:33 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:15807 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267389AbTAVIpd>; Wed, 22 Jan 2003 03:45:33 -0500
Date: Wed, 22 Jan 2003 03:54:30 -0500 (EST)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Andries.Brouwer@cwi.nl
cc: torvalds@transmeta.com, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix setpgid
In-Reply-To: <UTC200301202203.h0KM3V602042.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.44.0301220353580.32383-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 20 Jan 2003 Andries.Brouwer@cwi.nl wrote:

> In patch-2.5.37 a return code of setpgid(pid,pgid) was broken. If pid is
> not the current process and is not a child of the current process it
> should return ESRCH, but the 2.5.37 patch turned this into EINVAL. The
> below fixes this again.

indeed, thanks for the fix.

	Ingo

