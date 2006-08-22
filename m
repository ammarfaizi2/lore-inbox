Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932330AbWHVSQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbWHVSQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 14:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbWHVSQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 14:16:27 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:22183 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932330AbWHVSQ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 14:16:27 -0400
Subject: Re: [PATCH] paravirt.h
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Zachary Amsden <zach@vmware.com>
Cc: Andi Kleen <ak@muc.de>, virtualization@lists.osdl.org,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <44EB40A3.50700@vmware.com>
References: <1155202505.18420.5.camel@localhost.localdomain>
	 <200608221550.57603.ak@muc.de> <20060822142519.GX11651@stusta.de>
	 <200608221654.10558.ak@muc.de>  <44EB40A3.50700@vmware.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 22 Aug 2006 19:35:03 +0100
Message-Id: <1156271703.27114.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-08-22 am 10:36 -0700, ysgrifennodd Zachary Amsden:
> Write protection is great as a debug option to find accidental memory 
> corruptions.  It is useless as a technique to prevent subversion.  Um 
> hello, you're already at CPL-0.  Just rewrite the page tables already.

That depends upon how clever you are.  However if you want to load a
hypervisor under a running kernel and from it then you need an updatable
paravirt_ops.

Alan
