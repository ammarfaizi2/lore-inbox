Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262873AbTIVFSa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 01:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262968AbTIVFRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 01:17:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:12955 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262965AbTIVFR3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 01:17:29 -0400
Date: Sun, 21 Sep 2003 22:18:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Robert Love <rml@tech9.net>
Cc: herbert@13thfloor.at, cmrivera@ufl.edu, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE]  slab information utility
Message-Id: <20030921221849.7c4191c5.akpm@osdl.org>
In-Reply-To: <1064205590.8888.207.camel@localhost>
References: <1064199786.1199.29.camel@boobies.awol.org>
	<20030922042308.GA8691@DUK2.13thfloor.at>
	<1064205590.8888.207.camel@localhost>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love <rml@tech9.net> wrote:
>
>  > dm io                  0      0     36    0    0    1 :      0       0     0    0    0 :  252  126 :      0      0      0      0
> 
>  It is this bastard.  No easy way to parse text files when fields have
>  the delimiter in them, unfortunately.

Verboten.  I'll fix that up.  I'll also slip a BUG_ON(strchr(name, ' '));
into kmem_cache_create()...


