Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317257AbSFKX4V>; Tue, 11 Jun 2002 19:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317261AbSFKX4V>; Tue, 11 Jun 2002 19:56:21 -0400
Received: from [209.237.59.50] ([209.237.59.50]:39104 "EHLO
	zinfandel.topspincom.com") by vger.kernel.org with ESMTP
	id <S317257AbSFKX4T>; Tue, 11 Jun 2002 19:56:19 -0400
To: Thunder from the hill <thunder@ngforever.de>
Cc: "David S. Miller" <davem@redhat.com>, <oliver@neukum.name>,
        <wjhun@ayrnetworks.com>, <paulus@samba.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
In-Reply-To: <Pine.LNX.4.44.0206111657220.24261-100000@hawkeye.luckynet.adm>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 11 Jun 2002 16:56:14 -0700
Message-ID: <52d6ux5q01.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Thunder" == Thunder from the hill <thunder@ngforever.de> writes:

    Thunder> You introduce a possible null pointer dereference here,
    Thunder> don't you?

I left out the error checking for the allocations everywhere in my
email.  It wasn't real code and I thought that testing for NULL all
over the place would obscure the real point.

R.
