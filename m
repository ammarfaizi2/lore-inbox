Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262642AbTDHX4g (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 19:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262649AbTDHX4g (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 19:56:36 -0400
Received: from [12.47.58.221] ([12.47.58.221]:18163 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262642AbTDHX4f (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 19:56:35 -0400
Date: Tue, 8 Apr 2003 16:06:45 -0700
From: Andrew Morton <akpm@digeo.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 64-bit kdev_t - just for playing
Message-Id: <20030408160645.04bb6112.akpm@digeo.com>
In-Reply-To: <b6vnig$q86$1@cesium.transmeta.com>
References: <20030408195305.F19288@almesberger.net>
	<Pine.LNX.4.44.0304081607060.5766-100000@dlang.diginsite.com>
	<b6vnig$q86$1@cesium.transmeta.com>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Apr 2003 00:08:08.0815 (UTC) FILETIME=[1A01FFF0:01C2FE2C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> wrote:
>
> dev_t is already 64 bits in glibc, and the glibc<->kernel interface
> needs to be fixed *anyway*.  We have to take the pain of migration, we
> might as well go all the way.

If I understand the words of Andries and Linus correctly, that is the plan.

