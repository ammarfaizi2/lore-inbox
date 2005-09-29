Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbVI2X6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbVI2X6U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 19:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbVI2X6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 19:58:20 -0400
Received: from xproxy.gmail.com ([66.249.82.201]:38847 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932388AbVI2X6T convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 19:58:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MAAuAOABlb+C4CubVaUqwFt7KeB3OlJQjPxLuJ7Wx7AvfrX72VBRp6wNfaU14a7cU4s2p2edxi9H4kxbhZW/AaZ/xscD/hMYZWxpINEN9eh8R+jdHxRoExEEixoPp87/Gg8etIjDdgN5f9X9nN3bmzmGqNQGFZwY1RXZVyQLOUU=
Message-ID: <5bdc1c8b050929165866fbea81@mail.gmail.com>
Date: Thu, 29 Sep 2005 16:58:16 -0700
From: Mark Knecht <markknecht@gmail.com>
Reply-To: Mark Knecht <markknecht@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.14-rc2-mm2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050929164939.5329d6f0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050929143732.59d22569.akpm@osdl.org>
	 <5bdc1c8b050929162689415dd@mail.gmail.com>
	 <20050929164939.5329d6f0.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/05, Andrew Morton <akpm@osdl.org> wrote:
> Mark Knecht <markknecht@gmail.com> wrote:
> >
> > On 9/29/05, Andrew Morton <akpm@osdl.org> wrote:
> > >
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc2/2.6.14-rc2-mm2/
> > >
> > > (temp copy at http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.14-rc2-mm2.gz)
> > >
> >
> > Hi,
> >    I'm semi-sure at this point that the xrun problems I'm seeing on my
> > AMD64/NForce4 machine (Asus A8N-E motherboard) are isolated to the
> > SATA drive. Is there anything here that might address that? I'm
> > currently running 2.6.14-rc2-mm1. I've got this machine headless at
> > the moment. I can move data reliably using the CDRW drive, the DVD
> > drive with xine, and I can copy lots of data off and on my 1394
> > drives. I can run Ardour, Aqualung and lots of other apps remotely
> > using this machine as a server. When I start using the SATA drive,
> > read or write, I get lots xruns.
> >
>
> What is an xrun?
>
Jack, the audio server, misses a digital audio frame. I think xrun
means either an overrun or an underrun.

Basically Jack is running with extra priveledges expecting the system
to get out of its way when it needs to move audio data. It seems that
everything except my SAT drive is honoring this.

It all works great on my 32-bit machines. This is my first 64-bit. I'm
having troubles as are others. I think this is NForce4 specific.

Thanks,
Mark
