Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262446AbSJNUzj>; Mon, 14 Oct 2002 16:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262448AbSJNUzj>; Mon, 14 Oct 2002 16:55:39 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:64760 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262446AbSJNUzh>;
	Mon, 14 Oct 2002 16:55:37 -0400
Date: Mon, 14 Oct 2002 17:01:29 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: [PATCH] Export sockfd_lookup function
In-Reply-To: <5.1.0.14.2.20021014134001.083de250@mail1.qualcomm.com>
Message-ID: <Pine.GSO.4.21.0210141700010.6505-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 Oct 2002, Maksim (Max) Krasnyanskiy wrote:

> 
> Can we export sockfd_lookup function ?
> I need it in one of the Bluetooth modules which has to look up 'struct socket'
> from fd in the ioctl handler.

What the hell does that ioctl do with file descriptors in the first place?

