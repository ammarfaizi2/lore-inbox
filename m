Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285730AbRLYTO6>; Tue, 25 Dec 2001 14:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285732AbRLYTOu>; Tue, 25 Dec 2001 14:14:50 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:58529 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S285730AbRLYTOm>;
	Tue, 25 Dec 2001 14:14:42 -0500
Date: Tue, 25 Dec 2001 14:14:41 -0500
From: Legacy Fishtank <garzik@havoc.gtf.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Colonel <klink@clouddancer.com>, linux-kernel@vger.kernel.org
Subject: Re: 
Message-ID: <20011225141441.A14941@havoc.gtf.org>
In-Reply-To: <002001c18d5f$98cb62c0$010411ac@local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <002001c18d5f$98cb62c0$010411ac@local>; from manfred@colorfullife.com on Tue, Dec 25, 2001 at 05:17:01PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 25, 2001 at 05:17:01PM +0100, Manfred Spraul wrote:
> > When I went to build 2.4.17 on a dinky box (486, 16M RAM), the
> > config option was missing.  The box is a wall mount and is not very
> > capable of multiple kernel experimentation alas.  Can someone
> > supply some background as to what has happened?
> 
> It seems that RTNETLINK is now unconditionally enabled, I don't know
> why.

It's required by newer RedHat and MDK initscripts, perhaps others.
ip, iproute and similar utilities use it, and so since it's commonly
required DaveM made it unconditional...  I think the checkin comment was
something along the lines of "make it unconditional unless Alan
complains about kernel bloat" :)

	Jeff


