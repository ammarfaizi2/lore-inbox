Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129878AbRAAUOG>; Mon, 1 Jan 2001 15:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129999AbRAAUN4>; Mon, 1 Jan 2001 15:13:56 -0500
Received: from echo.sound.net ([205.242.192.21]:21469 "HELO echo.sound.net")
	by vger.kernel.org with SMTP id <S129878AbRAAUNo>;
	Mon, 1 Jan 2001 15:13:44 -0500
Date: Mon, 1 Jan 2001 13:35:18 -0600 (CST)
From: Hal Duston <hald@sound.net>
To: linux-kernel@vger.kernel.org
Subject: PS2ESDI
Message-ID: <Pine.GSO.4.10.10101011318090.5177-100000@sound.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In moving from 2.2.x to 2.4.x I have found that
PS/2 Esdi will no longer boot.  The problem was 
introduced by what appears to have been a small
architectural change that shouldn't have had an
impact.  I am looking into it, if anyone has an
idea of what could be causing this, please mail
me.  The relevant change occured at 2.3.32-pre3
A new parameter was add to xxx_do_request.  The
parameter isn't used by ps2esdi_do_request, but
I can't see why it should have caused any drive
problems.  Hopefully, I will figure the problem
out within the next week.

Not on the list,
Hal Duston
hald@sound.net

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
