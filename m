Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbTD3PW5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 11:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262281AbTD3PW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 11:22:57 -0400
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:17802 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S262282AbTD3PW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 11:22:56 -0400
Message-Id: <200304301533.h3UFXvGi023489@locutus.cmf.nrl.navy.mil>
To: Christoph Hellwig <hch@infradead.org>
cc: David Howells <dhowells@redhat.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add a stub by which a module can bind to the AFS syscall 
In-reply-to: Your message of "Wed, 30 Apr 2003 16:27:39 BST."
             <20030430162739.A9255@infradead.org> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Wed, 30 Apr 2003 11:33:57 -0400
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030430162739.A9255@infradead.org>,Christoph Hellwig writes:
>So fix the AFS code up to use a routine for each subcall that
>can still map to pioctl for !linux.  After that we can continue the
>discussion on how these calls are best implemented on linux.

because time is precious its quite a bit easier to fix one spot in 
the linux kernel than to fix a hundred or so in the afs code.
