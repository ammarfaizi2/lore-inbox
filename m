Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964931AbVHaWOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964931AbVHaWOf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 18:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964929AbVHaWOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 18:14:35 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:43186 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S964923AbVHaWOe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 18:14:34 -0400
X-ORBL: [67.124.117.85]
Date: Wed, 31 Aug 2005 15:14:24 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Alon Bar-Lev <alon.barlev@gmail.com>,
       Andrew Morton <akpm@osdl.org>, SYSLINUX@zytor.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit
Message-ID: <20050831221424.GA14806@taniwha.stupidest.org>
References: <4315B668.6030603@gmail.com> <43162148.9040604@zytor.com> <20050831215757.GA10804@taniwha.stupidest.org> <431628D5.1040709@zytor.com> <20050831220717.GA14625@taniwha.stupidest.org> <9a874849050831151230d68d64@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a874849050831151230d68d64@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 12:12:00AM +0200, Jesper Juhl wrote:

> b) add a new boot option telling the kernel the name of some file in
> initrd or similar from which to load additional options.

a file in initrd isn't a good choice; as the initrd is generally a fix
image

the point is some bootloaders might want to pass quite a bit of state
to the kernel at times (i actually have this for a mip32 target where
i construct a table and pass a pointer to that in, a tad icky but for
lack of options)
