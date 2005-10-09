Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbVJILoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbVJILoR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 07:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbVJILoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 07:44:17 -0400
Received: from mailfe10.tele2.fr ([212.247.155.44]:49568 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S932259AbVJILoQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 07:44:16 -0400
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
Date: Sun, 9 Oct 2005 13:44:06 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: akpm@osdl.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [patch 3/4] new serial flow control
Message-ID: <20051009114406.GE5104@bouh.residence.ens-lyon.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	akpm@osdl.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <200501052341.j05Nfod27823@mail.osdl.org> <20050105235301.B26633@flint.arm.linux.org.uk> <20051008222711.GA5150@bouh.residence.ens-lyon.fr> <20051009000153.GA23083@flint.arm.linux.org.uk> <20051009002129.GJ5150@bouh.residence.ens-lyon.fr> <20051009083724.GA14335@flint.arm.linux.org.uk> <20051009100909.GF5150@bouh.residence.ens-lyon.fr> <20051009111718.GA13144@flint.arm.linux.org.uk> <20051009113313.GD5104@bouh.residence.ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051009113313.GD5104@bouh.residence.ens-lyon.fr>
User-Agent: Mutt/1.5.9i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Thibault, le Sun 09 Oct 2005 13:33:13 +0200, a écrit :
> 
> Russell King, le Sun 09 Oct 2005 12:17:18 +0100, a écrit :
> > > Hardward flow control is usually performed in software. Can't their
> > > hardware implementation of hardware flow control be disabled when
> > > control method is not usual RTS/CTS?
> > 
> > You missed the point.  Of course the hardware flow control can be
> > disabled.  However, if you do have on-chip CTS flow control disabled
> > with UARTs with large FIFOs,
> > etc..
> 
> Yes, of course. But can't this be disabled too?

(I mean, the FIFOs)
