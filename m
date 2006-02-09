Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422799AbWBIE5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422799AbWBIE5Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 23:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422800AbWBIE5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 23:57:25 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:34530 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1422799AbWBIE5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 23:57:25 -0500
Date: Wed, 8 Feb 2006 20:56:39 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: dada1@cosmosbay.com, riel@redhat.com, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, mingo@elte.hu, ak@muc.de, 76306.1226@compuserve.com,
       wli@holomorphy.com, heiko.carstens@de.ibm.com
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
Message-Id: <20060208205639.c5e1b6ad.pj@sgi.com>
In-Reply-To: <20060208204502.12513ae5.akpm@osdl.org>
References: <200602051959.k15JxoHK001630@hera.kernel.org>
	<Pine.LNX.4.63.0602081728590.31711@cuia.boston.redhat.com>
	<20060208190512.5ebcdfbe.akpm@osdl.org>
	<20060208190839.63c57a96.akpm@osdl.org>
	<43EAC6BE.2060807@cosmosbay.com>
	<20060208204502.12513ae5.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> That comment came from the tender pinkies of pj@sgi.com, although I suspect
> it was just a transliteration of then-current practice.

You give my pinkie more credit than is its due.

That comment looks bogus.

Hmmm ... what should it be ...

 *  #ifdef CONFIG_HOTPLUG_CPU
 *     cpu_possible_map - has bit 'cpu' set iff cpu could be populated

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
