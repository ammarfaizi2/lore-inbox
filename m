Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269276AbUJFOb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269276AbUJFOb6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 10:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269273AbUJFOb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 10:31:58 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:28842 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269272AbUJFObw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 10:31:52 -0400
Subject: Re: [Patch] new serial flow control
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: =?ISO-8859-1?Q?S=E9bastien?= Hinderer 
	<Sebastien.Hinderer@libertysurf.fr>,
       rmk@arm.linux.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041006073847.GA2026@bouh.is-a-geek.org>
References: <20041004225430.GF2593@bouh.is-a-geek.org>
	 <20041004225530.GG2593@bouh.is-a-geek.org>
	 <1097016674.23924.12.camel@localhost.localdomain>
	 <20041006071110.GA1112@galois>  <20041006073847.GA2026@bouh.is-a-geek.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097069353.29251.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 06 Oct 2004 14:29:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-10-06 at 08:38, Samuel Thibault wrote:
> No: CRTSCTS is a one-signal-for-each-way flow control: each
> side of the link tells whether it can receive data. CTVB is a
> two-signals-for-only-one-way flow control: the device tells when it
> wants to send data, the PC acknowledges that, and then one frame of
> data can pass.

This sounds a lot like RS485 and some other related stuff. I need to
poke my pet async guru and find out if they are the same thing. If so
that would be useful.

