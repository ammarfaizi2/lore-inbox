Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273534AbRIQIe2>; Mon, 17 Sep 2001 04:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273535AbRIQIeI>; Mon, 17 Sep 2001 04:34:08 -0400
Received: from AMontpellier-201-1-1-55.abo.wanadoo.fr ([193.252.31.55]:18948
	"EHLO awak") by vger.kernel.org with ESMTP id <S273534AbRIQIeC>;
	Mon, 17 Sep 2001 04:34:02 -0400
Subject: Re: Forced umount (was lazy umount)
From: Xavier Bestel <xavier.bestel@free.fr>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20010917095744.C22640@niksula.cs.hut.fi>
In-Reply-To: <Pine.GSO.4.21.0109141427070.11172-100000@weyl.math.psu.edu>
	<3BA4D554.4030203@foogod.com>  <20010917095744.C22640@niksula.cs.hut.fi>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.14.21.31 (Preview Release)
Date: 17 Sep 2001 10:29:23 +0200
Message-Id: <1000715364.4446.12.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:

> I want an operation that will:
> 
> 1. Interrupt/Abort any processes disk-waiting on the filesystem

Why ? Can't you just return -EBADHANDLE, -E(NX)IO or something similar ?
Aborting should be reserved to mmap()ing processes.

       Xav

