Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129801AbQLDRYE>; Mon, 4 Dec 2000 12:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129819AbQLDRXy>; Mon, 4 Dec 2000 12:23:54 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:63505 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129801AbQLDRXm>; Mon, 4 Dec 2000 12:23:42 -0500
Date: Mon, 4 Dec 2000 10:52:31 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0.12.4: drivers/net/dummy.c fails compile
In-Reply-To: <200012041633.eB4GXOt26866@pincoya.inf.utfsm.cl>
Message-ID: <Pine.LNX.3.96.1001204105134.9128D-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2000, Horst von Brand wrote:
> SPARC64, Red Hat 6.2 + local updates

A better patch has already been posted, and is present in the
2.4.0-test11-ac series.  module.h needs to be modified to protect the
argument of SET_MODULE_OWNER.

	Jeff



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
