Return-Path: <linux-kernel-owner+w=401wt.eu-S1751921AbWLNQlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921AbWLNQlx (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 11:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751727AbWLNQlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 11:41:53 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:46022 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751946AbWLNQlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 11:41:52 -0500
Date: Thu, 14 Dec 2006 08:40:26 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH] slab: fix kmem_ptr_validate prototype
In-Reply-To: <1166099200.32332.233.camel@twins>
Message-ID: <Pine.LNX.4.64.0612140839440.28557@schroedinger.engr.sgi.com>
References: <1166099200.32332.233.camel@twins>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1700579579-648802997-1166114426=:28557"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1700579579-648802997-1166114426=:28557
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 14 Dec 2006, Peter Zijlstra wrote:

> Some fallout of: 2e892f43ccb602e8ffad73396a1000f2040c9e0b
>=20
>   CC mm/slab.o /usr/src/linux-2.6-git/mm/slab.c:3557: error: conflicting=
=20
> types for =FF=FFkmem_ptr_validate=FF=FF=20
> /usr/src/linux-2.6-git/include/linux/slab.h:58: error: previous=20
> declaration of =FF=FFkmem_ptr_validate=FF=FF was here

Why do we need the fastcall there? What is its role?

---1700579579-648802997-1166114426=:28557--
