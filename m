Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276628AbRJUTOq>; Sun, 21 Oct 2001 15:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276632AbRJUTOg>; Sun, 21 Oct 2001 15:14:36 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:11721 "EHLO
	mailout01.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S276628AbRJUTOY>; Sun, 21 Oct 2001 15:14:24 -0400
Content-Type: text/plain; charset=US-ASCII
From: Tim Jansen <tim@tjansen.de>
To: James Simmons <jsimmons@transvirtual.com>
Subject: Re: The new X-Kernel !
Date: Sun, 21 Oct 2001 21:17:25 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.LNX.4.10.10110211025130.13079-100000@transvirtual.com>
In-Reply-To: <Pine.LNX.4.10.10110211025130.13079-100000@transvirtual.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <15vO3W-0DSqTwC@fmrl00.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 October 2001 19:40, James Simmons wrote:
> It sets the hardware state of the keyboards and the
> mice. The user runs apps that alter the state. The second user comes along
> and log in on desktop two. He runs another small application to test the
> mice. It changes the state which in turn effects the person on desktop
> one.

Isn't this a driver problem? If two processes can interfere when using the 
same device the driver should only allow one access (one device file opened) 
at a time. And if two processes need to access it it should be managed by a 
daemon. 

bye...
