Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270926AbTHKCPb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 22:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270928AbTHKCPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 22:15:31 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:25221 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S270926AbTHKCP2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 22:15:28 -0400
Date: Mon, 11 Aug 2003 03:15:12 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Matt Mackall <mpm@selenic.com>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       jmorris@intercode.com.au
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030811021512.GF10446@mail.jlokier.co.uk>
References: <20030809074459.GQ31810@waste.org> <20030809010418.3b01b2eb.davem@redhat.com> <20030809140542.GR31810@waste.org> <20030809103910.7e02037b.davem@redhat.com> <20030809194627.GV31810@waste.org> <20030809131715.17a5be2e.davem@redhat.com> <20030810081529.GX31810@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030810081529.GX31810@waste.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> > > Ok, can I export some more cryptoapi primitives?

Why so complicated?  Just move the "sha1_transform" function to its
own file in lib, and call it from both drivers/char/random.c and
crypto/sha1.c.

Problem solved.

-- Jamie
