Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964889AbWHHO6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbWHHO6O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 10:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964892AbWHHO6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 10:58:14 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:41091 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964889AbWHHO6N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 10:58:13 -0400
Subject: Re: memory resource accounting (was Re: [RFC, PATCH 0/5] Going
	forward with Resource Management - A	cpu controller)
From: Dave Hansen <haveblue@us.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Martin Bligh <mbligh@mbligh.org>, rohitseth@google.com,
       Kirill Korotaev <dev@sw.ru>, vatsa@in.ibm.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       mingo@elte.hu, sam@vilain.net, linux-kernel@vger.kernel.org,
       dev@openvz.org, efault@gmx.de, balbir@in.ibm.com, sekharan@us.ibm.com,
       nagar@watson.ibm.com, pj@sgi.com, Andrey Savochkin <saw@sw.ru>
In-Reply-To: <44D89D7D.8040006@yahoo.com.au>
References: <20060804050753.GD27194@in.ibm.com>
	 <20060803223650.423f2e6a.akpm@osdl.org>
	 <20060803224253.49068b98.akpm@osdl.org>
	 <1154684950.23655.178.camel@localhost.localdomain>
	 <20060804114109.GA28988@in.ibm.com> <44D35F0B.5000801@sw.ru>
	 <44D388DF.8010406@mbligh.org> <44D6EAFA.8080607@sw.ru>
	 <44D74F77.7080000@mbligh.org>  <44D76B43.5080507@sw.ru>
	 <1154975486.31962.40.camel@galaxy.corp.google.com>
	 <1154976236.19249.9.camel@localhost.localdomain>
	 <1154977257.31962.57.camel@galaxy.corp.google.com>
	 <44D798B1.8010604@mbligh.org>  <44D89D7D.8040006@yahoo.com.au>
Content-Type: text/plain
Date: Tue, 08 Aug 2006 07:57:00 -0700
Message-Id: <1155049020.19249.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-09 at 00:19 +1000, Nick Piggin wrote:
>    This does give you kernel (slab, pagetable, etc) allocations as well as
>    userspace. I don't like the idea of doing controllers for inode cache
>    and controllers for dentry cache, etc, etc, ad infinitum.

Those two might not be such a bad idea.  Of the slab in my system, 90%
is reliably from those two slabs alone.  Now, a controller for the
'Acpi-Operand' slab might be going too far. ;)

Certainly something we should at least consider down the road.

-- Dave

