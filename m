Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130177AbQLILRL>; Sat, 9 Dec 2000 06:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131117AbQLILRC>; Sat, 9 Dec 2000 06:17:02 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:52229 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S130177AbQLILQ5>; Sat, 9 Dec 2000 06:16:57 -0500
Date: Sat, 9 Dec 2000 04:46:15 -0600
To: Rasmus Andersen <rasmus@jaquet.dk>
Cc: dagb@brattli.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove warning from drivers/net/irda/w83977af_ir.c
Message-ID: <20001209044615.T6567@cadcamlab.org>
In-Reply-To: <20001208220030.K599@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001208220030.K599@jaquet.dk>; from rasmus@jaquet.dk on Fri, Dec 08, 2000 at 10:00:30PM +0100
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Rasmus Andersen]
> -static struct w83977af_ir *dev_self[] = { NULL, NULL, NULL, NULL};
> +static struct w83977af_ir *dev_self[];

How does the compiler know the size of the array?

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
