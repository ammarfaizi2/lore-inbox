Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318810AbSHLUYq>; Mon, 12 Aug 2002 16:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318811AbSHLUYq>; Mon, 12 Aug 2002 16:24:46 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32529 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318810AbSHLUYp>; Mon, 12 Aug 2002 16:24:45 -0400
Date: Mon, 12 Aug 2002 13:29:19 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@arcor.de>
cc: Rusty Russell <rusty@rustcorp.com.au>, <akpm@zip.com.au>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch 6/12] hold atomic kmaps across generic_file_read
In-Reply-To: <E17eBlU-0001nX-00@starship>
Message-ID: <Pine.LNX.4.33.0208121328280.1289-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 12 Aug 2002, Daniel Phillips wrote:
> 
> That's the whole point of this: it's not a bug anymore.  (It's a feature.)

Well, it's a feature only if _intentional_, so I think Rusty's argument 
was that we should call it something else than "copy_to/from_user()" if 
we're ready to accept the fact that it fails for random reasons..

		Linus

