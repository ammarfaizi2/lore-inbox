Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbTFXShj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 14:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262299AbTFXShj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 14:37:39 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12814 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262269AbTFXShi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 14:37:38 -0400
Date: Tue, 24 Jun 2003 11:51:19 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: Re: Provide example copy_in_user implementation
In-Reply-To: <20030624100610.GC159@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0306241149470.29644-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 24 Jun 2003, Pavel Machek wrote:
> 
> This patch adds example copy_in_user implementation (copy_in_user is
> needed for new ioctl32 implementation, all 64bit archs will need
> it)... Please apply,

Hell no.

This is an example of how to do things WRONG. In short, it's not an 
example we want to have in the kernel, or anywhere _near_ the kernel.

Do it right, or don't do it at all. Code this bad should not be allowed to 
exist, please remove it from your harddisk immediately. I will go and wash 
my eyes from just having looked at it.

		Linus

