Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314378AbSEFKUD>; Mon, 6 May 2002 06:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314379AbSEFKT6>; Mon, 6 May 2002 06:19:58 -0400
Received: from [195.89.159.99] ([195.89.159.99]:62448 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S314378AbSEFKT5>; Mon, 6 May 2002 06:19:57 -0400
Date: Mon, 6 May 2002 11:19:50 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: "J.A. Magallon" <jamagallon@able.es>,
        Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Plan for e100-e1000 in mainline
Message-ID: <20020506111950.A1956@kushida.apsleyroad.org>
In-Reply-To: <20020501010828.GA1753@werewolf.able.es> <3CCF796C.5090401@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> You can easily copy drivers/net/e100[0] into a 2.4.x kernel, it likely 
> compiles without modification.

It does, except that you need to
  #define cpu_relax() rep_nop()
or something very similar.

Fwiw, the e100 driver from 2.5, running on 2.4, can forward at a
somewhat higher packet rate than the e100 which Red Hat 7.2 provides
with 2.4...

-- Jamie
