Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267241AbTGGTbl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 15:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267244AbTGGTbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 15:31:41 -0400
Received: from air-2.osdl.org ([65.172.181.6]:58054 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267241AbTGGTbk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 15:31:40 -0400
Date: Mon, 7 Jul 2003 12:46:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: trond.myklebust@fys.uio.no
Cc: vandrove@vc.cvut.cz, linux-kernel@vger.kernel.org
Subject: Re: opening symlinks with O_CREAT under latest 2.5.74
Message-Id: <20030707124618.603f7e5f.akpm@osdl.org>
In-Reply-To: <16137.51802.41123.551648@charged.uio.no>
References: <20030707154628.GA3220@vana.vc.cvut.cz>
	<16137.51802.41123.551648@charged.uio.no>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
>
> Whoops. Looks like I missed an assumption in open_namei().
> Does the following patch fix the problem?

Yes.
