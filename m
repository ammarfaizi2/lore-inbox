Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132479AbRBEAV2>; Sun, 4 Feb 2001 19:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132445AbRBEAVS>; Sun, 4 Feb 2001 19:21:18 -0500
Received: from shell.ca.us.webchat.org ([216.152.64.152]:51394 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S132479AbRBEAVK>; Sun, 4 Feb 2001 19:21:10 -0500
From: "David Schwartz" <davids@webmaster.com>
To: <mathieu_dube@videotron.ca>, <linux-kernel@vger.kernel.org>
Subject: RE: accept
Date: Sun, 4 Feb 2001 16:14:52 -0800
Message-ID: <NCBBLIEPOCNJOAEKBEAKGEKHNHAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
In-Reply-To: <01020411401700.00110@grndctrl>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Ok, but fd 0 cant be a valid socket since its the stdin

	Wrong. fd 0 can be a valid socket. Read the man page to 'accept' again.
Remember again that zero is a non-negative integer.

> I posted that on this mailing list coz I thought that this might
> be a scaling
> problem since it happens when theres already several clients
> connected to the
> server

	If your code called 'perror' in response to getting a zero from 'accept',
your code is broken.

	DS

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
