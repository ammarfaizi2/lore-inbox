Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136391AbREDOG0>; Fri, 4 May 2001 10:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136393AbREDOGQ>; Fri, 4 May 2001 10:06:16 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:13 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136391AbREDOGM>; Fri, 4 May 2001 10:06:12 -0400
Subject: Re: Athlon/VIA Kernel Experimentation (mmx.c)
To: bergsoft@home.com (Seth Goldberg)
Date: Fri, 4 May 2001 15:09:57 +0100 (BST)
Cc: gbsadler1@lcisp.com (Gordon Sadler), linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
In-Reply-To: <3AF27C39.9BD7EC99@home.com> from "Seth Goldberg" at May 04, 2001 02:54:01 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14vgHR-0007OF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> is to find out why this copy is not working properly...
> 
> For me the output is:
> 
> ...
> Freeing unused kernel memory: 188k freed     
> Kernel panic: fast_page_copy: dest value @ 0xcfed1000 (39312036) does
> not equal source value @ cfed4000(79005b)!

Swap the panic for a printk/BUG() and see who the caller was

