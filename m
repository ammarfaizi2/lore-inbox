Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317017AbSFFRV3>; Thu, 6 Jun 2002 13:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317026AbSFFRV2>; Thu, 6 Jun 2002 13:21:28 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:61855 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S317017AbSFFRV2>; Thu, 6 Jun 2002 13:21:28 -0400
Date: Thu, 6 Jun 2002 12:21:23 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Szabolcs Berecz <szabi@mplayerhq.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use $(CONFIG_SHELL instead of . in Makefile
In-Reply-To: <Pine.LNX.4.33.0206052105440.11996-100000@mail.mplayerhq.hu>
Message-ID: <Pine.LNX.4.44.0206061220020.31896-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jun 2002, Szabolcs Berecz wrote:

> sh ignores parameters when using . , so we should use $(CONFIG_SHELL)
> instead.

It's fixed differently in the latest tree (by making mkversion_h 
executable and executing instead of sourcing it).

Thanks, though.

--Kai



