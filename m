Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbTFGA67 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 20:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262482AbTFGA66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 20:58:58 -0400
Received: from dp.samba.org ([66.70.73.150]:28317 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262427AbTFGA6k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 20:58:40 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16097.15154.285695.493400@argo.ozlabs.ibm.com>
Date: Sat, 7 Jun 2003 11:09:06 +1000
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: __user annotations
In-Reply-To: <20030607010601.GF5554@conectiva.com.br>
References: <16097.12932.161268.783738@argo.ozlabs.ibm.com>
	<Pine.LNX.4.44.0306061738200.31112-100000@home.transmeta.com>
	<20030607010601.GF5554@conectiva.com.br>
X-Mailer: VM 7.16 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo Carvalho de Melo writes:

> In 3.3 this style is not accepted (haven't read the c99 draft to see if it is
> OK)

Ah, thank you, that explains it, since gcc-3.3 is now the default in
debian sid.  In fact it does compile OK for me with gcc-3.2.  (I
previously said it didn't but that was because I said `CC=gcc-3.2
make' not 'make CC=gcc-3.2'.)

Paul.
