Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263702AbREYLDt>; Fri, 25 May 2001 07:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263704AbREYLDj>; Fri, 25 May 2001 07:03:39 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:61964 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263702AbREYLD1>; Fri, 25 May 2001 07:03:27 -0400
Subject: Re: ac15 and 2.4.5-pre6, pwc format conversion
To: preining@logic.at (Norbert Preining)
Date: Fri, 25 May 2001 12:00:58 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, webcam@smcc.demon.nl
In-Reply-To: <20010525085024.A17867@alpha.logic.tuwien.ac.at> from "Norbert Preining" at May 25, 2001 08:50:24 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E153FL0-0006PB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> According to ac ChangeLog:
> o       Rip format conversion out of the pwc driver     (me)
>         | It belongs in user space..
> 
> This change is included in 2.4.5-pre6, but
> drivers/usb/pwc-uncompress.c
> still relies on this files:

Looks like I managed to send Linus a partial patch only. My fault-will fix
