Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264716AbTBSUCF>; Wed, 19 Feb 2003 15:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266804AbTBSUCF>; Wed, 19 Feb 2003 15:02:05 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:36292 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S264716AbTBSUCE>; Wed, 19 Feb 2003 15:02:04 -0500
Date: Wed, 19 Feb 2003 14:11:29 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Richard Henderson <rth@twiddle.net>
cc: Linus Torvalds <torvalds@transmeta.com>, <rusty@rustcorp.com.au>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] eliminate warnings in generated module files
In-Reply-To: <20030218221656.A23989@twiddle.net>
Message-ID: <Pine.LNX.4.44.0302191407470.24975-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2003, Richard Henderson wrote:

> On Tue, Feb 18, 2003 at 09:16:35PM -0800, Linus Torvalds wrote:
> > Some people are still using 2.95, I think anything past that is long since 
> > unsupported and not worth worrying about.

I tried egcs-2.91.66 (not sure if the sparc people are still using that?),
looks ok.

I merged the patch into my kbuild tree.

However, I'm not quite happy with "__attribute_used__".

Other examples of similar defines:

__deprecated
__init
__exit

So what about "__used" ? Admittedly, it's a bit short, but I like it 
better anyhow.

--Kai


