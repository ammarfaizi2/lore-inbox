Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbVBNWjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVBNWjH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 17:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVBNWjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 17:39:07 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:13732
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261250AbVBNWi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 17:38:57 -0500
Date: Mon, 14 Feb 2005 14:36:36 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH 2.6 1/2] Fix documentation build failure
Message-Id: <20050214143636.3c073df6.davem@davemloft.net>
In-Reply-To: <20050214200017.GA29201@sirius.home>
References: <20050214200017.GA29201@sirius.home>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Feb 2005 23:00:17 +0300
Sergey Vlasov <vsu@altlinux.ru> wrote:

> In linux-2.6.11-rc4-bk2 building of the documentation (make htmldocs)
> fails on "DOCPROC Documentation/DocBook/kernel-api.sgml" because of
> these errors:
> 
> Error(/home/vsu/src/linux-2.6.11-rc4-bk2/include/linux/skbuff.h:936): cannot understand prototype: '#ifndef CONFIG_HAVE_ARCH_DEV_ALLOC_SKB '
> Error(/home/vsu/src/linux-2.6.11-rc4-bk2/drivers/video/fbmem.c:1265): cannot understand prototype: 'const char *global_mode_option; '

I think the htmldoc parser should be fixed instead.
