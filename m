Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263772AbRFMOMb>; Wed, 13 Jun 2001 10:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263780AbRFMOMU>; Wed, 13 Jun 2001 10:12:20 -0400
Received: from firewall.ocs.com.au ([203.34.97.9]:61683 "EHLO ocs4.ocs-net")
	by vger.kernel.org with ESMTP id <S263772AbRFMOMN>;
	Wed, 13 Jun 2001 10:12:13 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "David S. Miller" <davem@redhat.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.6-pre3 unresolved symbol do_softirq 
In-Reply-To: Your message of "Wed, 13 Jun 2001 07:06:42 MST."
             <15143.29554.888847.108615@pizda.ninka.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 14 Jun 2001 00:11:57 +1000
Message-ID: <10347.992441517@ocs4.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2001 07:06:42 -0700 (PDT), 
"David S. Miller" <davem@redhat.com> wrote:
>
>Keith Owens writes:
> > OTOH if any *.S code is compiled into a module then all symbols it
> > refers to must be EXPORT_SYMBOL_NOVERS().
>
>Why not just add --include modversions.h to the gcc command line to
>build it, why wouldn't this work?

Assembler code is not hooked into the generic module symbol version
handling.  Every .S rule is unique and I'm not going to change every
one.

