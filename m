Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265196AbSL0XUa>; Fri, 27 Dec 2002 18:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262913AbSL0XU0>; Fri, 27 Dec 2002 18:20:26 -0500
Received: from m68-mp1.cvx3-a.ren.dial.ntli.net ([213.104.120.68]:56311 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id <S262604AbSL0XTa>; Fri, 27 Dec 2002 18:19:30 -0500
Subject: Re: Hotswap IDE mobile rack
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Max Lapshin <max@ask-me.ru>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021226103208.GA5792@ask-me.ru>
References: <20021226103208.GA5792@ask-me.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 27 Dec 2002 23:26:27 +0000
Message-Id: <1041031587.1128.5.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-12-26 at 10:32, Max Lapshin wrote:
> 	This problem has already been discussed here, but it seems that there
> are no conclusions. Is it possible to make work correctly subject in
> Linux? This device can only turn off and on power on one IDE device.
> It's a pity, if it is not possible, because in Windows it work fine.

It depends how the device works. I wouldn't recommend it without knowing
more details. The core code can unregister/reregister IDE interfaces but
it isnt yet very elegant.

Alan

