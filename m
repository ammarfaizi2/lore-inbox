Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267653AbUHMW5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267653AbUHMW5n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 18:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267654AbUHMW5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 18:57:42 -0400
Received: from the-village.bc.nu ([81.2.110.252]:47578 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267653AbUHMW4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 18:56:44 -0400
Subject: Re: x86 - Realmode BIOS and Code calling module
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jakub Vana <gugux@centrum.cz>
Cc: vojtech@suse.cz, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040813143618Z2102821-29041+51849@mail.centrum.cz>
References: <20040813143618Z2102821-29041+51849@mail.centrum.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092434063.24989.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 13 Aug 2004 22:54:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-08-13 at 15:36, Jakub Vana wrote:
> But when running in LRMI there are same problems, aren't ?

vm86 mode running in user space faults I/O port accesses if you wish so
you can decode them and re-run them through the kernel PCI layer as for
example Xorg does.

Alan

