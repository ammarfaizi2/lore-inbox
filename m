Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277178AbRJVRSj>; Mon, 22 Oct 2001 13:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277154AbRJVRST>; Mon, 22 Oct 2001 13:18:19 -0400
Received: from www.transvirtual.com ([206.14.214.140]:50954 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S277123AbRJVRSP>; Mon, 22 Oct 2001 13:18:15 -0400
Date: Mon, 22 Oct 2001 10:18:36 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Jesse Pollard <jesse@cats-chateau.net>
cc: Tim Jansen <tim@tjansen.de>, linux-kernel@vger.kernel.org
Subject: Re: The new X-Kernel !
In-Reply-To: <01102119103200.19723@tabby>
Message-ID: <Pine.LNX.4.10.10110221016020.1738-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sunday 21 October 2001 14:17, Tim Jansen wrote:
> > On Sunday 21 October 2001 19:40, James Simmons wrote:
> > > It sets the hardware state of the keyboards and the
> > > mice. The user runs apps that alter the state. The second user comes
> > > along and log in on desktop two. He runs another small application to
> > > test the mice. It changes the state which in turn effects the person on
> > > desktop one.
> >
> > Isn't this a driver problem? If two processes can interfere when using the
> > same device the driver should only allow one access (one device file
> > opened) at a time. And if two processes need to access it it should be
> > managed by a daemon.
> 
> Neither - It is a resource allocation problem, which all UNIX style systems

[snip]...

I think everyone has misunderstood me. I know I'm not the most clear
person sometimes. I'm just talking about fine grain locking of some kind
between input devices. I really like to see "direct input" in OpenGL
someday. You need some kind of locking between OpenGL and the X server in
this case just like you have with graphics.

