Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264692AbSJUCX4>; Sun, 20 Oct 2002 22:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264693AbSJUCX4>; Sun, 20 Oct 2002 22:23:56 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:3503 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S264692AbSJUCXz>; Sun, 20 Oct 2002 22:23:55 -0400
Date: Sun, 20 Oct 2002 21:29:58 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Gregoire Favre <greg@ulima.unil.ch>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.44 Oops (ISDN)
In-Reply-To: <20021020171306.GA15607@ulima.unil.ch>
Message-ID: <Pine.LNX.4.44.0210202127380.25262-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Oct 2002, Gregoire Favre wrote:

> (syncppp don't compil already reported)

Yup, that's known, I'm working on it.

> as 2.5.44 with syncppp doesn't compil, I tried to compil without, but it
> Oops at boot:

Someone converted HiSax to struct workqueue, which is not really the right 
fix, BTW, and messed up.

ISDN has been badly broken by removing various old-fashioned APIs, it'll 
take a bit to stabilize again.

--Kai

