Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263156AbUDZXi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263156AbUDZXi4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 19:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263079AbUDZXi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 19:38:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17115 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262907AbUDZXiy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 19:38:54 -0400
Date: Mon, 26 Apr 2004 16:37:58 -0700
From: "David S. Miller" <davem@redhat.com>
To: "Petri T. Koistinen" <petri.koistinen@iki.fi>
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/sunrpc/svcauth_unix.c: unix_domain_find: return
 NULL if kmalloc fails
Message-Id: <20040426163758.4a407cb4.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0404261913550.5531@dsl-prvgw1cc4.dial.inet.fi>
References: <Pine.LNX.4.58.0404261913550.5531@dsl-prvgw1cc4.dial.inet.fi>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Apr 2004 19:17:19 +0300 (EEST)
"Petri T. Koistinen" <petri.koistinen@iki.fi> wrote:

> I browsed http://linuxbugs.coverity.com/ site and found this:
> 
> NULL_RETURNS error: Dereference of possibly NULL ptr "new" returned by "kmalloc".
 ...
> Is this correct fix? What happens when unix_domain_find return NULL?
