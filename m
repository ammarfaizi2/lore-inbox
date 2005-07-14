Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262659AbVGNRZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262659AbVGNRZK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 13:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262645AbVGNRZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 13:25:09 -0400
Received: from graphe.net ([209.204.138.32]:16619 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261607AbVGNRYi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 13:24:38 -0400
Date: Thu, 14 Jul 2005 10:24:33 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: David Gibson <david@gibson.dropbear.id.au>
cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
Subject: Re: RFC: Hugepage COW
In-Reply-To: <20050707055554.GC11246@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0507141022440.14347@graphe.net>
References: <20050707055554.GC11246@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jul 2005, David Gibson wrote:

> Now that the hugepage code has been consolidated across the
> architectures, it becomes much easier to implement copy-on-write.
> Hugepage COW is of limited utility of itself, however, it is
> essentially a prerequisite for any of a number of methods of allowing
> userland programs to automatically use hugepages without code changes
> e.g. hugepage malloc() libraries, implicit hugepage mmap(), hugepage
> ELF segments.  For certain applications (particularly enormous HPC
> FORTRAN programs), these can result in a large performance
> improvement.
> 
> Thoughts?  Flames?

Great stuff. I am glad that you are cleaning up the hugepages and are 
making progress improving them. What are your thoughts on implementing 
fault handling for huge pages?


