Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280632AbRKGLys>; Wed, 7 Nov 2001 06:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280631AbRKGLyi>; Wed, 7 Nov 2001 06:54:38 -0500
Received: from druid.if.uj.edu.pl ([149.156.64.221]:1286 "HELO
	druid.if.uj.edu.pl") by vger.kernel.org with SMTP
	id <S280524AbRKGLy0>; Wed, 7 Nov 2001 06:54:26 -0500
Date: Wed, 7 Nov 2001 12:53:44 +0100 (CET)
From: Maciej Zenczykowski <maze@druid.if.uj.edu.pl>
To: Gunther Mayer <Gunther.Mayer@t-online.de>
Cc: Thomas Hood <jdthood@mail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.12-ac3 floppy module requires 0x3f0-0x3f1 ioports
In-Reply-To: <3BE841C4.947416CB@t-online.de>
Message-ID: <Pine.LNX.4.33.0111071252230.4304-100000@druid.if.uj.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Nov 2001, Gunther Mayer wrote:
> Solution:
> ---------
> PnPBIOS in linux should _not_ reserve these 2 ports (this kind of
> solution is commonly called a quirks).

Actually, you may be right that it should not, however the floppy module
should not allocate these ports `with an even more sure` as it never uses
them.

Think this is the proper solution?

MaZe.

