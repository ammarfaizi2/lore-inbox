Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbTD3Oq0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 10:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbTD3Oq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 10:46:26 -0400
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:43913 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S261942AbTD3OqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 10:46:25 -0400
Message-Id: <200304301457.h3UEvMGi023283@locutus.cmf.nrl.navy.mil>
To: Christoph Hellwig <hch@infradead.org>
cc: David Howells <dhowells@redhat.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add a stub by which a module can bind to the AFS syscall 
In-reply-to: Your message of "Wed, 30 Apr 2003 15:02:11 BST."
             <20030430150211.A7024@infradead.org> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Wed, 30 Apr 2003 10:57:22 -0400
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030430150211.A7024@infradead.org>,Christoph Hellwig writes:
>Umm, you're adding a handler so that a module can register a variadic
>multiplexer syscall??  I think you need to rething your design..

i dont believe it needs to be a variadic (the afs syscall will/uses the
first params).  however, the syscall interface for afs predates linux.
changing to a different interface just for linux kernels seems somewhat
costly (programmers time) when this existing interface has been well
tested and debugged on several other operating systems.
