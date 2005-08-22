Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751270AbVHVWLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbVHVWLt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbVHVWLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:11:49 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:57990 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751270AbVHVWLq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:11:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VZpHZBwLuse/0s1flZYUVXyX3+Ny34EdrpeY9ZTUOh+AVvoBwthztknX5Blgillk8FLenN/LJTlI6Uo3POp2xXpNe//cks5Gj69BV/84rdNvbzg2BhYyLIC+P0xq4g+v++xPbhgGlZvdYodw0x89AhJGAwEkl9D1zlH031QDTpE=
Message-ID: <58cb370e05082204471220a99c@mail.gmail.com>
Date: Mon, 22 Aug 2005 13:47:01 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: IRQ problem with PCMCIA
Cc: David Hinds <dhinds@sonic.net>, "Hesse, Christian" <mail@earthworm.de>,
       linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org
In-Reply-To: <1124710216.7281.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200508212043.58331.mail@earthworm.de>
	 <20050821221739.GA18925@sonic.net> <20050821221935.GB18925@sonic.net>
	 <1124671082.1101.0.camel@localhost.localdomain>
	 <58cb370e050822022556595fa1@mail.gmail.com>
	 <1124706770.7281.13.camel@localhost.localdomain>
	 <58cb370e05082203325eb55c03@mail.gmail.com>
	 <1124710216.7281.19.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Llu, 2005-08-22 at 12:32 +0200, Bartlomiej Zolnierkiewicz wrote:
> > I'll keep trying you can keep whining.
> 
> Actually I'm rather busy porting the old ATA drivers over to the new
> SATA layer right now. HPT and VIA will be nasty to do but the simpler
> drivers are moving over quite nicely.

Porting drivers is the easiest part.
The hard part is providing all needed infrastructure.

> Now back to ata_serverworks.c

Good, it will make also my work easier (merging IDE/libata).
It is a bit shame that you haven't started with ata_821x.c.

Bartlomiej
