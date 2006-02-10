Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbWBJHz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbWBJHz1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 02:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbWBJHz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 02:55:27 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:19644 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751182AbWBJHz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 02:55:26 -0500
Date: Fri, 10 Feb 2006 09:55:19 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Christoph Lameter <clameter@engr.sgi.com>,
       Manfred Spraul <manfred@colorfullife.com>, vatsa@in.ibm.com,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>
Subject: Re: [patch] slab: Avoid deadlock at kmem_cache_create/kmem_cache_destroy
In-Reply-To: <20060209182923.GA3576@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0602100953000.26917@sbz-30.cs.Helsinki.FI>
References: <20060209182923.GA3576@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Feb 2006, Ravikiran G Thirumalai wrote:
> Prevents deadlock situation between kmem_cache_create()/kmem_cache_destory(),
> and kmem_cache_create() /cpu hotplug.  The locking order probably got 
> moved over time.

Looks good to me.

			Pekka
