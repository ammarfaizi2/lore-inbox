Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265210AbTLFQnA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 11:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265211AbTLFQnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 11:43:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:31928 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265210AbTLFQm5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 11:42:57 -0500
Date: Sat, 6 Dec 2003 08:42:53 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ethan Weinstein <lists@stinkfoot.org>
cc: Tero Knuutila <tero1001@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: cdrecord hangs my computer
In-Reply-To: <3FD1994C.10607@stinkfoot.org>
Message-ID: <Pine.LNX.4.58.0312060841400.2092@home.osdl.org>
References: <Law9-F31u8ohMschTC00001183f@hotmail.com>
 <Pine.LNX.4.58.0312060011130.2092@home.osdl.org> <3FD1994C.10607@stinkfoot.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 6 Dec 2003, Ethan Weinstein wrote:
>
> I've noted this at boot several times with 2.6.0-test11
>
> Dec  4 23:59:21 e-d0uble kernel: ide-scsi is deprecated for cd burning!
> Use ide-cd and give dev=/dev/hdX as device

Yup.

> Removing the ide-cd bootparams: (I didn't try the patch)
>
> Cdrecord 2.00.3 seems to like the sony-dru500a, denoted as
> --dev=/dev/hdc, I burned several disks this way.

Good. However, I'd still like to hear if ide-scsi.c works with the patch:
it's deprecated and I don't actually encourage people to use it, but it
would be interesting to hear whether it works for people..

		Linus
