Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032306AbWLGPi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032306AbWLGPi1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 10:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937997AbWLGPi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 10:38:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50612 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937998AbWLGPi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 10:38:26 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <200612070650.49232.david-b@pacbell.net> 
References: <200612070650.49232.david-b@pacbell.net>  <20061207124419.17680.96380.stgit@warthog.cambridge.redhat.com> 
To: David Brownell <david-b@pacbell.net>
Cc: linux-arm-kernel@lists.arm.linux.org.uk,
       David Howells <dhowells@redhat.com>, ben@fluff.org, torvalds@osdl.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Fix spi_bitbang.h 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 07 Dec 2006 15:37:35 +0000
Message-ID: <28598.1165505855@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell <david-b@pacbell.net> wrote:

> NAK.  Headers don't compile.  A driver including this _might_ need to
> include that header; most won't.

Please be more specific.  It compiles for myself and for Ben.  I used the
s3c2410_defconfig configuration.  It won't compile without it.

David
