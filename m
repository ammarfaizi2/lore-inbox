Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265901AbTAFDTw>; Sun, 5 Jan 2003 22:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265987AbTAFDTv>; Sun, 5 Jan 2003 22:19:51 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8456 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265865AbTAFDSV>; Sun, 5 Jan 2003 22:18:21 -0500
Date: Sun, 5 Jan 2003 19:21:38 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Luca Barbieri <ldb@ldb.ods.org>
cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Introduce TIF_IRET and use it to disable sysexit
In-Reply-To: <20030106021250.GB8074@ldb>
Message-ID: <Pine.LNX.4.44.0301051921080.1403-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 6 Jan 2003, Luca Barbieri wrote:
>
> This patch introduces a new flag called TIF_IRET and uses it in place
> of TIF_SIGPENDING when that flag is used to force return via iret.

Thanks. Both (this and the %ebp fix) patches applied, looks fine.

		Linus

