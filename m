Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261319AbVCGQgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbVCGQgP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 11:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbVCGQgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 11:36:15 -0500
Received: from rproxy.gmail.com ([64.233.170.204]:35669 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261319AbVCGQgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 11:36:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=nveX9jrPU5LRF1M3sKsDdwIckIPKr9vyP7CGwzX/Rmez3z1L4lWJqOtDsv+/dUXDLzwBaJ5SfX4g3Z1MrBJGpj6YdPn1PZvL7LB0HiwNYsY/1cK8xOVFb9bzyXWlxfKITeBjoaip1LISnAUIl47uAeUsYV7njvgHXdNL81f/e3E=
Message-ID: <d120d50005030708365a4917c5@mail.gmail.com>
Date: Mon, 7 Mar 2005 11:36:08 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Henrik Persson <root@fulhack.info>
Subject: Re: Touchpad "tapping" changes in 2.6.11?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <422C7CF3.9080609@fulhack.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <422C539A.4040407@fulhack.info>
	 <d120d500050307055522415fb3@mail.gmail.com>
	 <422C7CF3.9080609@fulhack.info>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Mar 2005 17:10:27 +0100, Henrik Persson <root@fulhack.info> wrote:
> Dmitry Torokhov wrote:
> > On Mon, 07 Mar 2005 14:14:02 +0100, Henrik Persson <root@fulhack.info> wrote:
> >
> >>Hi there.
> >>
> >>I noticed that the ALPS driver was added to 2.6.11, a thing that alot of
> >>people probably like, but since my touchpad (Acer Aspire 1300XV) worked
> >>perfectly before (like, 2.6.10) and now the ALPS driver disables
> >>'hardware tapping', wich makes it hard to tap. I commented out the
> >>disable-tapping bits in alps.c and now it's working like a charm again.
> >>
> >
> >
> > Hi,
> >
> > Could you please try 2.6.11-mm1. It has bunch of Peter Osterlund's
> > patches that shoudl improve the situation with tapping.
> 
> Well, -mm1 didn't quite agree with my savage gfx drivers. But I'm
> booting with psmouse.proto=exps now, and it's working the way I'm used
> to now.
> 
> The Aspire 1300-series is quite different from the 1350 ones.. The
> touchpad on the 1300 will work like a charm without the synaptics driver
> (but no fancy stuff is supported, I guess). Before you could boot and be
> happy without the synaptics driver, now you probably have to install the
> synaptics driver to be happy.. Maybe that's not so good. :)
> 
> Could this touchpad use the "exps" proto as default and then you could
> reconfigure if you want to use the ALPS driver..?
> 

We (well Peter and Vojtech mostly as I don't have ALPS touchpad in my
box) are trying to make ALPS work as it was working before even
without Synaptics X driver without any additional options, please bear
with us.

Still I think having Synaptics driver installed is the best way in the
end simply because it has a lot of knobs so one can adjust tpouchpad's
behavior to his/her liking. Maybe once distibutions start packaging
and activating it by default it will be less of an issue.

-- 
Dmitry
