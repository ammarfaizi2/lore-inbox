Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261526AbVBAECr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbVBAECr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 23:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbVBAECr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 23:02:47 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:3223 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261526AbVBAECq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 23:02:46 -0500
Message-Id: <200502010210.j112ARfA023361@laptop11.inf.utfsm.cl>
To: Matt Mackall <mpm@selenic.com>
cc: Andrew Morton <akpm@osdl.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] lib/sort: Heapsort implementation of sort() 
In-Reply-To: Message from Matt Mackall <mpm@selenic.com> 
   of "Mon, 31 Jan 2005 01:34:59 MDT." <2.416337461@selenic.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Mon, 31 Jan 2005 23:10:27 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> said:
> This patch adds a generic array sorting library routine. This is meant
> to replace qsort, which has two problem areas for kernel use.

Another problem is the GPL license. It will certainly be wanted from
non-GPL (e.g., binary) modules. Please just EXPORT_SYMBOL it.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
