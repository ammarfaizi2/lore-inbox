Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267569AbTBLQG7>; Wed, 12 Feb 2003 11:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267608AbTBLQG7>; Wed, 12 Feb 2003 11:06:59 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:55311 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267569AbTBLQGx>; Wed, 12 Feb 2003 11:06:53 -0500
Date: Wed, 12 Feb 2003 16:16:41 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Thomas Molina <tmolina@cox.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: problems with console configuration
In-Reply-To: <Pine.LNX.4.44.0302121000590.9224-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0302121614180.31435-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> All good stuff, but I occasionally have problems seeing the video display 
> as an input device :)  

Misunderstanding. The input api devices are used for input devices like 
keyboards and such. On the other end we have display drivers. Now I for
the framebuffer console I have seperated the console code out of the low 
level drivers.

> It sometimes turns into an adventure syncing with 
> the latest bk archive and wondering what I need to do to get console and 
> keyboard.

Input api built in. Sorry but the VT console system isn,t modular yet. 
Enable framebuffer devices and then go into the console menu at the bottom 
and select framebuffer console support.

