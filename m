Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266733AbTBQERF>; Sun, 16 Feb 2003 23:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266718AbTBQERF>; Sun, 16 Feb 2003 23:17:05 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:9658 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S266772AbTBQERB>; Sun, 16 Feb 2003 23:17:01 -0500
Date: Sun, 16 Feb 2003 22:26:48 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Brian Gerst <bgerst@didntduck.org>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Move __this_module to xxx.mod.c 
In-Reply-To: <20030217042330.D50DE2C04D@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0302162225420.5217-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2003, Rusty Russell wrote:

> I don't think so: the symbol will be in the module by the time
> module-init-tools gets to it, or am I missing something?

Yes, but modprobe will look for .gnu.linkonce.__this_module if it wants to 
change the name (but that's now in ___this_module).

--Kai

