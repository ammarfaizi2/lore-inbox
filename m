Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264282AbTKTFIi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 00:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264283AbTKTFIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 00:08:38 -0500
Received: from dp.samba.org ([66.70.73.150]:44174 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264282AbTKTFIh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 00:08:37 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Takashi Iwai <tiwai@suse.de>
Cc: arvidjaar@mail.ru, linux-kernel@vger.kernel.org
Subject: Re: modules.pnpmap output support 
In-reply-to: Your message of "Mon, 17 Nov 2003 15:05:36 BST."
             <s5hoevbjdjj.wl@alsa2.suse.de> 
Date: Thu, 20 Nov 2003 15:35:28 +1100
Message-Id: <20031120050836.BFA712C2D5@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <s5hoevbjdjj.wl@alsa2.suse.de> you write:
> --Multipart_Mon_Nov_17_15:05:36_2003-1
> Content-Type: text/plain; charset=US-ASCII
> 
> At Mon, 17 Nov 2003 14:34:08 +0100,
> I wrote:
> > 
> > at first i'll try to add the support of old isapnp format for
> > compatibility, so that old programs can work as they are.
> 
> done.
> 
> Rusty, could you check whether it's ok?

Hmm, I had to modify it a little.  You have to be careful for 32-bit
and 64-bit kernels, and I added a couple of tests to the testsuite.  I
have uploaded -pre4 with these changes in it.

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
