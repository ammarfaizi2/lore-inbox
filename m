Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268009AbTCFL3c>; Thu, 6 Mar 2003 06:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268011AbTCFL3c>; Thu, 6 Mar 2003 06:29:32 -0500
Received: from ns.suse.de ([213.95.15.193]:57102 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S268009AbTCFL3c>;
	Thu, 6 Mar 2003 06:29:32 -0500
To: Mikael Pettersson <mikpe@user.it.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: x86-64 fixes for 2.4.21-pre5
References: <15974.15180.311304.526712@gargle.gargle.HOWL.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 06 Mar 2003 12:40:04 +0100
In-Reply-To: Mikael Pettersson's message of "5 Mar 2003 19:05:37 +0100"
Message-ID: <p73isuw67vv.fsf@amdsimf.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@user.it.uu.se> writes:

> This fixes a linkage error caused by the IDE layer's use of the
> new ndelay() macro. I simply cloned the i386 implementation.
> 
> This also silences two assembler warnings in bootsect.S and setup.S.
> Those warnings are caused by a change in binutils' behaviour a LONG
> time ago. This can't be fixed for i386 in the official stable kernel
> since it breaks old tool chains, but that's not an issue for x86-64.

I fixed it some time ago in my tree, but Marcelo dropped the fixes,
sorry.

Will retransmit it later with a full patchkit and many more bug fixes.

-Andi
