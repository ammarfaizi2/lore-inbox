Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261317AbRESUbX>; Sat, 19 May 2001 16:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261288AbRESUbN>; Sat, 19 May 2001 16:31:13 -0400
Received: from mailproxy.de.uu.net ([192.76.144.34]:6638 "EHLO
	mailproxy.de.uu.net") by vger.kernel.org with ESMTP
	id <S261291AbRESUbD>; Sat, 19 May 2001 16:31:03 -0400
Content-Type: text/plain; charset=US-ASCII
From: Tim Jansen <tim@tjansen.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: no ioctls for serial ports? [was Re: LANANA: To Pending Device Number Registrants]
Date: Sat, 19 May 2001 22:31:49 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <20010519211717.A7961@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.21.0105191231020.14472-100000@penguin.transmeta.com> <20010519214321.A9550@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20010519214321.A9550@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Message-Id: <01051922314901.00754@cookie>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 19 May 2001 21:43, Pavel Machek wrote:
> I think that plan9 uses something different -- they have ttyS0 and
> ttyS0ctl. This would leave us with problem "how do I get handle to
> ttyS0ctl when I only have handle to ttyS0"?

One possibility is to add multiforked (multi-stream) file support to Linux, 
then you could have a control stream. 


bye...
