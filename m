Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129666AbQLEVND>; Tue, 5 Dec 2000 16:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129652AbQLEVMx>; Tue, 5 Dec 2000 16:12:53 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:54021 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S130371AbQLEVMj>; Tue, 5 Dec 2000 16:12:39 -0500
Date: Tue, 5 Dec 2000 14:41:32 -0600
To: Ivan Passos <lists@cyclades.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com
Subject: Re: [RFC-2] Configuring Synchronous Interfaces in Linux
Message-ID: <20001205144132.D6567@cadcamlab.org>
In-Reply-To: <E143Ebi-000500-00@the-village.bc.nu> <Pine.LNX.4.10.10012051118140.1713-100000@main.cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10012051118140.1713-100000@main.cyclades.com>; from lists@cyclades.com on Tue, Dec 05, 2000 at 11:23:50AM -0800
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Ivan Passos]
> - One ioctl that passes a pointer to a known structure in
>   ifr.ifr_data as its argument.

struct sync_params_ioctl_data {
  int opcode;
  union {......

Seems straightforward to me.  Basically just ioctl numbers within ioctl
numbers.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
