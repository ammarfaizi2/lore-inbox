Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262772AbUKRN11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbUKRN11 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 08:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262773AbUKRN1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 08:27:13 -0500
Received: from imag.imag.fr ([129.88.30.1]:65014 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S262772AbUKRNYm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 08:24:42 -0500
Date: Thu, 18 Nov 2004 14:24:34 +0100 (CET)
From: Catalin Drula <Catalin.Drula@imag.fr>
To: Alex Riesen <raa.lkml@gmail.com>
cc: Catalin Drula <catalin.drula@imag.fr>, <linux-kernel@vger.kernel.org>
Subject: Re: AF_UNIX sockets: strange behaviour
In-Reply-To: <81b0412b04111714426d82cab2@mail.gmail.com>
Message-ID: <Pine.GSO.4.33.0411181411080.10966-100000@horus.imag.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (imag.imag.fr [129.88.30.1]); Thu, 18 Nov 2004 14:24:35 +0100 (CET)
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 17 Nov 2004, Alex Riesen wrote:

> On Wed, 17 Nov 2004 16:29:14 +0100 (CET), Catalin Drula
> <catalin.drula@imag.fr> wrote:
> > I have a small application that communicates over Bluetooth. I use
> > connection-oriented UNIX domain sockets (AF_UNIX, SOCK_STREAM) to
> > communicate between the applications's threads. When reading from
> > one of these sockets, I get a strange behaviour: if I read all the
> > bytes that are available (13, in this case) all at once, it's fine;
> > however, if I try to read in two smaller batches (say, first time
> > 6, and second time 7), the first read returns (with the 6 bytes), but
> > the second read never returns.
>
> 2.6.9, works. Could you post your code?

Nevermind. It was actually a bug in my code. I apologize for wasting
your time.

Catalin

