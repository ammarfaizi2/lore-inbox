Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760178AbWLDA6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760178AbWLDA6N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 19:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760179AbWLDA6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 19:58:13 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:48271 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1760178AbWLDA6N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 19:58:13 -0500
Message-Id: <200612040057.kB40vurM019005@laptop13.inf.utfsm.cl>
To: Aucoin@Houston.RR.com
cc: "'Tim Schmielau'" <tim@physik3.uni-rostock.de>,
       "'Andrew Morton'" <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: la la la la ... swappiness 
In-Reply-To: Message from "Aucoin" <Aucoin@Houston.RR.com> 
   of "Sun, 03 Dec 2006 17:56:30 MDT." <200612032356.kB3NuPc0010673@ms-smtp-04.texas.rr.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
Date: Sun, 03 Dec 2006 21:57:56 -0300
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Recipient e-mail whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Sun, 03 Dec 2006 21:58:01 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aucoin <Aucoin@Houston.RR.com> wrote:
> We want it to swap less for this particular operation because it is low
> priority compared to the rest of what's going on inside the box.

The swapping is not a "operation" thing, it is global for /all/ what is
going on in the box. And having it swap less means assigning it more RAM,
i.e., giving it higher (not lower) priority than other stuff happening at
the same time.

I guess I don't understand what your needs are (not what you want to do to
get there).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
