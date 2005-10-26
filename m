Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932604AbVJZI7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932604AbVJZI7m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 04:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932605AbVJZI7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 04:59:42 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:20097 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932604AbVJZI7l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 04:59:41 -0400
Date: Wed, 26 Oct 2005 10:59:29 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       prw@ceiriog1.demon.co.uk
Subject: Re: [2.6-git PATCH] Fix for HFSPlus, should go in before 2.6.14!
In-Reply-To: <Pine.LNX.4.64.0510260817360.3412@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.61.0510261053300.1386@scrub.home>
References: <Pine.LNX.4.64.0510260817360.3412@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 26 Oct 2005, Anton Altaparmakov wrote:

> Please apply before you release 2.6.14 if at all possible as HFS+ is 
> seriously borked without it...  I have now given up waiting for Roman to 
> reply given my original mail to him was two weeks ago and you are about 
> to release 2.6.14...

I haven't responded yet, because I didn't have the time to verify and test 
the problem yet. It's not "seriously borked", it doesn't crash, it still 
works and the problem is easily fixed by fsck, so it wasn't on the top of 
my todo list.
The patch looks fine, although I'd probably prefered to move this kind of 
initialization into a separate function, as it's duplicated right now.

bye, Roman
