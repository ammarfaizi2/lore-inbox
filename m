Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262577AbULPBVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbULPBVE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 20:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262593AbULPBUB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 20:20:01 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:39297 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262545AbULPBB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 20:01:27 -0500
Subject: Re: [2.6 patch] net/lapb/lapb_iface.c: remove unused code
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Jonathan Naylor <g4klx@g4klx.demon.co.uk>, netdev@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041215010745.GB12937@stusta.de>
References: <20041215010745.GB12937@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1103155101.3585.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 15 Dec 2004 23:58:22 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-12-15 at 01:07, Adrian Bunk wrote:
> The patch below removes the following unused code:
> - EXPORT_SYMBOL'ed functions lapb_getparms and lapb_setparms
> - struct lapb_parms_struct
> 
> Please review whether it's correct or conflicts with pending changes.

Please keep these, they are used by out of kernel code and they are also
required in order to run test sets on the full code functionality.

