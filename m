Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbVBFPUD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVBFPUD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 10:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbVBFPUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 10:20:03 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:3812 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261158AbVBFPTr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 10:19:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=CD3P8JIilDsjIwB6vfXBpMjFDfL8Kj4q0DpfsWQFTV6sjcB0bJ+rIH2YR0r3FIztR39UF0UmPsp/YXBpLaL0b8/mfwwiJmldRYIGTKDz5qDMMWsgzltokv6eIEPNDvcU4o4TAvpHCIereo90JfwqVL2sU28Eb67RoiUtHeW6ke8=
Message-ID: <58cb370e05020607197db9ecf4@mail.gmail.com>
Date: Sun, 6 Feb 2005 16:19:44 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [ANNOUNCE] "iswraid" (ICHxR ataraid sub-driver) for 2.4.29
Cc: Arjan van de Ven <arjan@infradead.org>, Martins Krikis <mkrikis@yahoo.com>,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk
In-Reply-To: <420631BF.7060407@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <87651hdoiv.fsf@yahoo.com> <420582C6.7060407@pobox.com>
	 <1107682076.22680.58.camel@laptopd505.fenrus.org>
	 <58cb370e050206044513eb7f89@mail.gmail.com>
	 <42062BFE.7070907@pobox.com>
	 <1107701373.22680.115.camel@laptopd505.fenrus.org>
	 <420631BF.7060407@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 06 Feb 2005 10:03:27 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:
> Arjan van de Ven wrote:
> >>I consider it not a new feature, but a missing feature, since otherwise
> >>user data cannot be accessed in the RAID setups.
> >
> >
> > the same is true for all new hardware drivers and hardware support
> > patches. And for new DRM (since new X may need it) and new .. and
> > new ... where is the line?
> >
> > for me a deep maintenance mode is about keeping existing stuff working;
> > all new hw support and derivative hardware support (such as this) can be
> > pointed at the new stable series... which has been out for quite some
> > time now..
> 
> Red herring.
> 
> 2.4.x has ICH5/6 support -- but is missing the RAID support component.
> 
> We are talking about hardware that is ALREADY supported by 2.4.x kernel,
> not new hardware.
> 
> We are also talking about inability to access data on hardware supported
> by 2.4.x, not something that can easily be ignored or papered over with
> a compatibility mode.

the same arguments can be used for crypto support etc.,
answer is - use 2.6.x or add extra patches to get 2.4.x working
