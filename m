Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264782AbTFBBgq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 21:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264783AbTFBBgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 21:36:46 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:516 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264781AbTFBBgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 21:36:44 -0400
Date: Sun, 1 Jun 2003 18:49:41 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: linux-ide@vger.kernel.org, <linux-kernel@vger.kernel.org>,
       "Adam J. Richter" <adam@yggdrasil.com>
Subject: Re: [FIX] Re: 2.5.70-bk[56] breaks disk partitioning with multiple
 IDE disks
In-Reply-To: <20030601235333.GN9502@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44.0306011849050.16521-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 2 Jun 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> vi drivers/ide/ide.c -c'/drive->list.*driver->drives/s/list_add/&_tail/|x'

Mind sending me a patch? There's only so much I like doing with vi 
scripts, and this went over my threshold.

		Linus

