Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263521AbTETQ2x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 12:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263547AbTETQ2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 12:28:52 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:38061 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id S263521AbTETQ2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 12:28:52 -0400
Date: Tue, 20 May 2003 11:41:47 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: mikpe@csd.uu.se
cc: Brian Gerst <bgerst@didntduck.org>, Sam Ravnborg <sam@ravnborg.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Update fs Makefiles
In-Reply-To: <16074.18029.571091.558335@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.4.44.0305201139020.24017-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 May 2003 mikpe@csd.uu.se wrote:

> Kai Germaschewski writes:
>  > o Possibly add "-y" support to 2.4 (it's a pretty trivial change)
> 
> That's the worst thing you could do for those of us maintaining
> 2.4/2.5 compatibility in drivers etc.
> Having to check "oh I'm in 2.4, let's see if I'm in 2.4.23 or
> $VENDOR 2.4.blah because then these random 2.5-like changes occurred"
> sucks like h*ll.

It'd be an additional feature, i.e. if it causes trouble for the code you 
maintain, don't use it.

People who want a Makefile which works in all 2.4 + vendor then would 
choose to stay with -objs, whereas people who prefer do have 2.4.latest 
and 2.5 in sync could use -y, like, I'd guess, USB.

--Kai


