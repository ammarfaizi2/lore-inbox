Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278957AbRJVVia>; Mon, 22 Oct 2001 17:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278972AbRJVVhd>; Mon, 22 Oct 2001 17:37:33 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:64783 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278962AbRJVVhX>; Mon, 22 Oct 2001 17:37:23 -0400
Subject: Re: hfs cdrom broken in 2.4.13pre
To: pochini@denise.shiny.it (Giuliano Pochini)
Date: Mon, 22 Oct 2001 22:44:16 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <3BD1F4B5.D8D74DBF@denise.shiny.it> from "Giuliano Pochini" at Oct 21, 2001 12:03:33 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15vmro-0003Ut-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Kernel 2.4.13pre1 on powerpc. I can no longer mount HFS-formatted cdroms.
> The last kernel I'm sure it worked fine is 2.4.7

Mount it over loopback device. We at some point need to make that bit
transparent.
