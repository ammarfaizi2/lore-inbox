Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbWGEG4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWGEG4y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 02:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWGEG4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 02:56:54 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:11222 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751285AbWGEG4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 02:56:53 -0400
Date: Wed, 5 Jul 2006 09:56:52 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Alessio Sangalli <alesan@manoweb.com>
cc: Linus Torvalds <torvalds@osdl.org>,
       Daniel Ritz <daniel.ritz-ml@swissonline.ch>,
       Dave Jones <davej@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cardbus: revert IO window limit
In-Reply-To: <Pine.LNX.4.64.0606301614470.12404@g5.osdl.org>
Message-ID: <Pine.LNX.4.58.0607050955450.24209@sbz-30.cs.Helsinki.FI>
References: <200607010003.31324.daniel.ritz-ml@swissonline.ch>
 <Pine.LNX.4.64.0606301516140.12404@g5.osdl.org> <200607010109.40486.daniel.ritz-ml@swissonline.ch>
 <Pine.LNX.4.64.0606301614470.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jun 2006, Linus Torvalds wrote:
> Alessio, try Daniel's patch. We'd love to hear if it works, and in 
> particular what the dmesg output is (if it does work, it should print out 
> something like
> 
> 	PIIX4 ACPI PIO at 2000-203f
> 	PIIX4 SMB PIO at 2040-204f
> 
> and perhaps even a few "PIIX4 devres X" lines..)
> 
> Alessio, it might also make sense to try to enable ACPI if you haven't 
> done so - not because you need to use it, but because sometimes the ACPI 
> table parsing also ends up exposing these kinds of things..

Alessio, did you have time to try out Daniel's patch?

				Pekka
