Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751764AbWBWTob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764AbWBWTob (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 14:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751768AbWBWTob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 14:44:31 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:7349 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751764AbWBWToa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 14:44:30 -0500
Date: Thu, 23 Feb 2006 20:44:24 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: make -j with j <= 4 seems to only load a single CPU core
In-Reply-To: <9a8748490602211302j61c0088fp8b555860e928028e@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0602232042440.23935@yvahk01.tjqt.qr>
References: <9a8748490602211302j61c0088fp8b555860e928028e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>This is quite odd and I've no idea where to start looking for the
>cause, but let me describe what I'm seeing and maybe someone can point
>me in the right direction.
>When I build new kernels I use 'make -j' to get both CPU cores busy
>and minimize build time.
>
I have seen something similar, but at a different point.
Often, `make -j2` makes make run in a way that only one instance of gcc is 
active at a time.


Jan Engelhardt
-- 
