Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267251AbUJFHiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267251AbUJFHiz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 03:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268915AbUJFHiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 03:38:55 -0400
Received: from iona.labri.fr ([147.210.8.143]:12970 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S267251AbUJFHix (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 03:38:53 -0400
Date: Wed, 6 Oct 2004 09:38:47 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: =?iso-8859-1?Q?S=E9bastien?= Hinderer 
	<Sebastien.Hinderer@libertysurf.fr>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, rmk@arm.linux.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] new serial flow control
Message-ID: <20041006073847.GA2026@bouh.is-a-geek.org>
Mail-Followup-To: =?iso-8859-1?Q?S=E9bastien?= Hinderer <Sebastien.Hinderer@libertysurf.fr>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, rmk@arm.linux.org.uk,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20041004225430.GF2593@bouh.is-a-geek.org> <20041004225530.GG2593@bouh.is-a-geek.org> <1097016674.23924.12.camel@localhost.localdomain> <20041006071110.GA1112@galois>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041006071110.GA1112@galois>
User-Agent: Mutt/1.5.6i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mer 06 oct 2004 à 09:11:10 +0200, Sébastien Hinderer a tapoté sur son clavier :
> > > Here is patch for 2.6
> > 
> > How is this different from CRTSCTS ?
> 
> I'd say it is symmetric. I think the roles of RTS and CTS are exchanged.
> Sam, am I right ?

No: CRTSCTS is a one-signal-for-each-way flow control: each
side of the link tells whether it can receive data. CTVB is a
two-signals-for-only-one-way flow control: the device tells when it
wants to send data, the PC acknowledges that, and then one frame of
data can pass.

Regards,
Samuel Thibault
