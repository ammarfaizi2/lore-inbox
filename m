Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264127AbTFIA52 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 20:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264124AbTFIA52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 20:57:28 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22021 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264127AbTFIA4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 20:56:32 -0400
Date: Sun, 8 Jun 2003 18:09:59 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ryan Anderson <ryan@michonline.com>
cc: linux-kernel@vger.kernel.org,
       <kernel-janitor-discuss@lists.sourceforge.net>
Subject: Re: [PATCH][SPARSE] Runtime detection of gcc include paths
In-Reply-To: <20030609011128.GI20872@michonline.com>
Message-ID: <Pine.LNX.4.44.0306081807500.1849-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 8 Jun 2003, Ryan Anderson wrote:
>
> This uses the same method as previously was used, it just performs the
> lookup at runtime.

I much prefer a compile-time thing.

Performance is, to me, paramount for "checker". I don't want to slow it 
down, I'm hoping that some day we can just enable C=1 by default in the 
kernel build (this is a _long_ time off, though, don't you all start 
worrying now).

I don't see anything wrong with a compile/install time thing, that is, 
after all, how gcc too works.

		Linus

