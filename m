Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291258AbSBRT1u>; Mon, 18 Feb 2002 14:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290926AbSBRTZR>; Mon, 18 Feb 2002 14:25:17 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17159 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287287AbSBRTXU>; Mon, 18 Feb 2002 14:23:20 -0500
Subject: Re: Non-root IPX
To: nix@go-nix.ca (Nix N. Nix)
Date: Mon, 18 Feb 2002 19:37:21 +0000 (GMT)
Cc: acme@conectiva.com.br, linux-kernel@vger.kernel.org
In-Reply-To: <1013922173.20865.12.camel@tux> from "Nix N. Nix" at Feb 17, 2002 12:02:53 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16ctbF-0006ZK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is this true ?  If so, what can I do to allow regular users to make IPX
> sockets ?  Is that a wise thing to do ?  I'm interested in running a
> Windows game (Starcraft) as a normal user.  WineX has gotten to the
> point where that is possible, minus IPX.

IPX sockets can be created by normal users. Server range sockets cannot
(as with most other non toy OS's). You need the right capabilities for
that. You can use a setuid helper to an app if its an issue, or just keep
the right capabiltiy bit
