Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317647AbSFLGrw>; Wed, 12 Jun 2002 02:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317648AbSFLGrw>; Wed, 12 Jun 2002 02:47:52 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:5892 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317647AbSFLGrv>; Wed, 12 Jun 2002 02:47:51 -0400
Subject: Re: bandwidth 'depredation'
To: marco@esi.it (Marco Colombo)
Date: Wed, 12 Jun 2002 08:08:49 +0100 (BST)
Cc: pochini@shiny.it (Giuliano Pochini), raul@pleyades.net (DervishD),
        linux-kernel@vger.kernel.org (Linux-kernel)
In-Reply-To: <Pine.LNX.4.44.0206111628280.17534-100000@Megathlon.ESI> from "Marco Colombo" at Jun 11, 2002 04:38:01 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17I2FN-0006y7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But so how is QoS going to change things? It's the output queue of
> the router on the other side of the ADLS link that needs management
> (and maybe you need to speak some protocol like RSVP), or am I missing
> something? How can you control the rate of *incoming* packets per
> connection / protocol? 

For  tcp it works fine. You drop stuff late but it still triggers
backoffs as needed
