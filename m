Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271956AbRIDLyb>; Tue, 4 Sep 2001 07:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271955AbRIDLyV>; Tue, 4 Sep 2001 07:54:21 -0400
Received: from eth0.gw-ma-a.ka.net.schlund.de ([195.20.224.6]:2483 "EHLO
	c3po.schlund.de") by vger.kernel.org with ESMTP id <S271956AbRIDLyF>;
	Tue, 4 Sep 2001 07:54:05 -0400
Date: Tue, 4 Sep 2001 13:54:24 +0200 (MEST)
From: Hannah Schroeter <hannah@schlund.de>
Message-Id: <200109041154.f84BsO503288@c3po.schlund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Calling user-space code from within module?
X-Newsgroups: ka.lists.linux.kernel
In-Reply-To: <AEEEJLJGDLODKEHHFIABMECPCFAA.kwooten@home.com>
Organization: Schlund + Partner AG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

In article <AEEEJLJGDLODKEHHFIABMECPCFAA.kwooten@home.com> you write:
>Is there any way to call a user-space function from within a kernel module,
>providing at some point a function pointer was passed in? If so how would
>you call this function if you were in the context of another process?

No precise hints, but you could look at the way how signal handler
functions are called.

Another way is to avoid the problem, using instead a userland<->kernel
socket (or similar) connection and some "remote procedure call" over
that socket.

Hope that helps a bit.

Kind regards,

Hannah.
