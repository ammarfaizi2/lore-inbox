Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967470AbWK2Qe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967470AbWK2Qe5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 11:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967472AbWK2Qe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 11:34:57 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:25279 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S967470AbWK2Qe5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 11:34:57 -0500
Date: Wed, 29 Nov 2006 16:41:30 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>,
       lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [PATCH -mm] char: drivers use/need PCI
Message-ID: <20061129164130.2789bb84@localhost.localdomain>
In-Reply-To: <456DB524.8000008@gmail.com>
References: <20061128211203.fa197b15.randy.dunlap@oracle.com>
	<456D4033.5000202@gmail.com>
	<456DB203.1090108@oracle.com>
	<456DB524.8000008@gmail.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But those drivers support ISA devices too. Ok then, let "&& PCI" be as a correct
> temporary way and I'll add "|| ISA" after the proposed code fix :).

That stops it being built on some platforms that have ISA and not PCI.
Seems a poor fix for what really is a couple of ifdefs
