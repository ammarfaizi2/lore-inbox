Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262507AbUBXW0v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 17:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262500AbUBXW0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 17:26:51 -0500
Received: from mx1.redhat.com ([66.187.233.31]:12221 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262510AbUBXW0t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 17:26:49 -0500
Date: Tue, 24 Feb 2004 17:26:59 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Christophe Saout <christophe@saout.de>
cc: Matt Mackall <mpm@selenic.com>, Jean-Luc Cooke <jlcooke@certainkey.com>,
       Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       James Morris <jmorris@intercode.com.au>
Subject: Re: [PATCH/proposal] dm-crypt: add digest-based iv generation mode
In-Reply-To: <1077651839.11170.4.camel@leto.cs.pocnet.net>
Message-ID: <Xine.LNX.4.44.0402241726450.26251-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Feb 2004, Christophe Saout wrote:

> BTW: I think there's a bug in the ipv6 code, it uses spin_lock to
> protect itself, this will cause a sleep-inside-spinlock warning. (found
> while grepping through the source for other cryptoapi users)

Where is the bug?


- James
-- 
James Morris
<jmorris@redhat.com>


