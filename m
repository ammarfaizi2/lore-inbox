Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262047AbUL1DDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262047AbUL1DDV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 22:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbUL1DCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 22:02:43 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:1702
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262036AbUL1DCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 22:02:04 -0500
Date: Mon, 27 Dec 2004 18:57:21 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net/sunrpc/: some cleanups
Message-Id: <20041227185721.6adb9867.davem@davemloft.net>
In-Reply-To: <20041212211907.GZ22324@stusta.de>
References: <20041212211907.GZ22324@stusta.de>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Dec 2004 22:19:07 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> The patch below contains the following cleanups:
> - make some needlessly global code static
> - remove the following unused global functions:
>   - net/sunrpc/auth_gss/gss_generic_token.c: g_get_mech_oid
>   - net/sunrpc/cache.c: cache_find
>   - net/sunrpc/cache.c: cache_drop
>   - net/sunrpc/xdr.c: xdr_decode_netobj_fixed
>   - net/sunrpc/xdr.c: xdr_shift_iovec
>   - net/sunrpc/xdr.c: xdr_kmap
>   - net/sunrpc/xdr.c: xdr_kunmap
> - remove the following unused global structs:
>   - net/sunrpc/auth_gss/gss_krb5_mech.c: gss_mech_krb5_oid
>   - net/sunrpc/auth_gss/gss_spkm3_mech.c: gss_mech_spkm3_oid
>   - net/sunrpc/rpc_pipe.c: rpc_pipe_iops
> - remove the EXPORT_SYMBOL(cache_clean)
> 
> Please review this patch.

Looks fine.  Applied, thanks Adrian.
