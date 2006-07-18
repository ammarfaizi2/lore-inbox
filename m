Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbWGRC6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWGRC6U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 22:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWGRC6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 22:58:20 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:22493 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751134AbWGRC6T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 22:58:19 -0400
Message-Id: <200607180258.k6I2wEFm012293@laptop11.inf.utfsm.cl>
To: "Vishal Patil" <vishpat@gmail.com>
cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: Generic B-tree implementation 
In-Reply-To: Message from "Vishal Patil" <vishpat@gmail.com> 
   of "Mon, 17 Jul 2006 22:02:43 -0400." <4745278c0607171902pc218a9dn9c63dd6670ac7249@mail.gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Mon, 17 Jul 2006 22:58:14 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Mon, 17 Jul 2006 22:58:16 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vishal Patil <vishpat@gmail.com> wrote:
> I am attaching source files containing a very generic implementation
> of B-trees in C. The implementation corresponds to in memory B-Tree
> data structure. The B-tree library consists of two files, btree.h and
> btree.c. I am also attaching a sample program main.c which should
> hopefully make the use of the library clear.

B-trees are useful mainly when you can get a bunch of pointers in one
swoop, i.e., by reading nodes from disk.

> I would be happy to receive inputs from the community for changes
> (enchancements) to the library. All the more I would like to help
> someone with a project which would take advantage of the B-Tree
> implementation.

Build infrastructure (== library) without clear users won't go very far on
LKML.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
