Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268512AbRGXXLC>; Tue, 24 Jul 2001 19:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268508AbRGXXKx>; Tue, 24 Jul 2001 19:10:53 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:21005 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268513AbRGXXKo>; Tue, 24 Jul 2001 19:10:44 -0400
Subject: Re: Arp problem
To: paul@clubi.ie (Paul Jakma)
Date: Wed, 25 Jul 2001 00:11:52 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), kubla@sciobyte.de (Dominik Kubla),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0107242128470.13997-100000@fogarty.jakma.org> from "Paul Jakma" at Jul 24, 2001 09:31:25 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15PBLE-00012l-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> however, in the interests of flexibility and kindness to admins who
> have to deal with legacy setups, is or would it be possible to make
> linux be able to fully route packets between interfaces bound to the
> same device?

Turn on ip forwarding, turn off ip redirect sending. It can all be done
via /proc.
