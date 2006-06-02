Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbWFBXZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbWFBXZd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 19:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbWFBXZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 19:25:33 -0400
Received: from wx-out-0102.google.com ([66.249.82.199]:9751 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751267AbWFBXZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 19:25:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=dYjzn/fMmr5p/G8D0HGEfnPCD0iYJJJcXT6D9tqmMO1RoxvCtdRrD4DwKmNEdhOfoXAJi12mgbj7/GQU9O2AbleQT38diQY127f+SX2N4jnNitBnp2vlGwW3bwwYD4hLwCUQJkeM4xdAhKAS+6qG5wbjbZj1EwhMSyd8+J5XC+c=
Message-ID: <4480C8D9.5080309@gmail.com>
Date: Sat, 03 Jun 2006 07:25:13 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: David Lang <dlang@digitalinsight.com>
CC: Pavel Machek <pavel@ucw.cz>, Ondrej Zajicek <santiago@mail.cz>,
       Jon Smirl <jonsmirl@gmail.com>, Dave Airlie <airlied@gmail.com>,
       "D. Hazelton" <dhazelton@enter.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
References: <200605272245.22320.dhazelton@enter.net>  <9e4733910605272027o7b59ea5n5d402dabdd7167cb@mail.gmail.com>  <200605280112.01639.dhazelton@enter.net>  <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com>  <9e4733910605281759j2e7bebe1h6e3f2bf1bdc3fc50@mail.gmail.com>  <Pine.LNX.4.63.0605301033330.4786@qynat.qvtvafvgr.pbz>  <447CBEC5.1080602@gmail.com> <20060602083604.GA2480@localhost.localdomain>  <20060602085832.GA25806@elf.ucw.cz>  <Pine.LNX.4.63.0606021146320.4686@qynat.qvtvafvgr.pbz> <20060602220104.GA6931@elf.ucw.cz> <Pine.LNX.4.63.0606021256470.4686@qynat.qvtvafvgr.pbz>
In-Reply-To: <Pine.LNX.4.63.0606021256470.4686@qynat.qvtvafvgr.pbz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:
> On Sat, 3 Jun 2006, Pavel Machek wrote:
>> I'm not talking about reading speed, I'm talking about displaying
>> speed. Once you display more than refresh rate times screen
>> size... you may as well cheat -- xterm-like. If xterm detects too much
>> stuff is being displayed, it simply stops displaying it, only
>> refreshing screen few times a second...
> 
> That would work, however AFAIK it's not implemented in any existing
> framebuffer.

Besides implementaton, the main concern with this is that you might miss
a very important kernel message.  Though one can always use the scrollback
buffer.

Tony
