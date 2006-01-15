Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbWAPRL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbWAPRL6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 12:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWAPRL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 12:11:58 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:31429 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751133AbWAPRL5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 12:11:57 -0500
Message-Id: <200601150446.k0F4kShR005019@laptop11.inf.utfsm.cl>
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org, rolandd@cisco.com
Subject: Re: [patch 2.6.15-mm4] sem2mutex: infiniband, #2 
In-Reply-To: Message from Ingo Molnar <mingo@elte.hu> 
   of "Sat, 14 Jan 2006 16:09:49 BST." <20060114150949.GA24284@elte.hu> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 18)
Date: Sun, 15 Jan 2006 01:46:28 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Mon, 16 Jan 2006 14:10:28 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
> semaphore to mutex conversion.
> 
> the conversion was generated via scripts, and the result was validated
> automatically via a script as well.

Note that the number of inserted/deleted lines don't match, sometimes the
line

  #include <linux/mutex.h>

is duplicated.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
