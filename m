Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265326AbUBBQoy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 11:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265657AbUBBQoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 11:44:54 -0500
Received: from fungus.teststation.com ([212.32.186.211]:57361 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id S265326AbUBBQox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 11:44:53 -0500
Date: Mon, 2 Feb 2004 17:45:15 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: puw@cola.local
To: Michael Jonsson <micke@lmpnet.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: smbfs build error kernel-2.6.1
In-Reply-To: <401D8E17.1020805@lmpnet.se>
Message-ID: <Pine.LNX.4.44.0402021743250.5232-100000@cola.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Feb 2004, Michael Jonsson wrote:

> Hi,
> 
> I get an error when I try to build kernel-2.6.1 with smbfs,
> 
> ************************************************
> make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
>   CHK     include/linux/compile.h
>   CC [M]  fs/smbfs/proc.o
> fs/smbfs/proc.c:33:19: proto.h: No such file or directory

Does fs/smbfs/proto.h exist?

If not, what did you do to remove it? It's there in the 2.6.1 I looked at,
and the build works for me.

/Urban

