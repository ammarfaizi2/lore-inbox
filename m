Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273729AbRIXBEr>; Sun, 23 Sep 2001 21:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273730AbRIXBEh>; Sun, 23 Sep 2001 21:04:37 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:39011 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S273729AbRIXBEW>; Sun, 23 Sep 2001 21:04:22 -0400
To: David Woodhouse <dwmw2@infradead.org>
Cc: John Weber <weber@nyc.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel pcmcia
In-Reply-To: <3BAE24F4.4489CC4A@nyc.rr.com> <12891.1001275605@redhat.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 23 Sep 2001 18:55:39 -0600
In-Reply-To: <12891.1001275605@redhat.com>
Message-ID: <m11ykx8l10.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> writes:

> weber@nyc.rr.com said:
> > Is cardmgr absolutely necessary?  I don't use modules, so I don't
> > really understand what cardmgr does that can't be done by the kernel
> > at boot. -
> 
> Aside from loading modules, it also performs the matching between devices 
> and drivers - rather than drivers registering a list of the devices they're 
> capable of driving, as with other bus types, cardmgr is required to 'bind' 
> devices to drivers.
> 
> The whole lot wants rewriting. I've been looking at it but don't have 
> anything that even compiles. 

I looked a while ago and the exported driver interfaces don't look to
bad but the code was next to impossible to follow.

Eric
