Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263111AbTEMBgx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 21:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263120AbTEMBgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 21:36:53 -0400
Received: from rth.ninka.net ([216.101.162.244]:26321 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263111AbTEMBgg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 21:36:36 -0400
Subject: Re: [PATCH] fix net/rxrpc/proc.c
From: "David S. Miller" <davem@redhat.com>
To: Chris Wright <chris@wirex.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20030512173801.A20068@figure1.int.wirex.com>
References: <20030512173801.A20068@figure1.int.wirex.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052790558.9169.2.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 12 May 2003 18:49:18 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-12 at 17:38, Chris Wright wrote:
> A recent change in 2.5.69-bk from Yoshfuji broke compilation of rxrpc
> code.  It erroneously adds an owner field to the rxrpc_proc_peers_ops
> seq_operations.  Fix below.

Why is it "erroneous"?  Just add the proper linux/module.h include
to net/rxrpc/proc.c instead of spewing baseless claims.

-- 
David S. Miller <davem@redhat.com>
