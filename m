Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030393AbWGHVSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030393AbWGHVSQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 17:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030395AbWGHVSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 17:18:16 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:22967 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030393AbWGHVSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 17:18:15 -0400
Subject: Re: pcmcia IDE broken in 2.6.18-rc1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org
In-Reply-To: <20060708104100.af5dcbd8.akpm@osdl.org>
References: <20060708145541.GA2079@elf.ucw.cz>
	 <1152380199.27368.9.camel@localhost.localdomain>
	 <20060708104100.af5dcbd8.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 08 Jul 2006 22:35:47 +0100
Message-Id: <1152394547.27368.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-07-08 am 10:41 -0700, ysgrifennodd Andrew Morton:
> +      	    io_base = (unsigned long) ioremap(req.Base, req.Size);
> +    	    ctl_base = io_base + 0x0e;
> +    	    is_mmio = 1;

Where does this get unmapped ?


