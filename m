Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261540AbVBAEfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbVBAEfr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 23:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbVBAEfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 23:35:46 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:16105
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261538AbVBAEfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 23:35:42 -0500
Date: Mon, 31 Jan 2005 20:29:52 -0800
From: "David S. Miller" <davem@davemloft.net>
To: "" <pmarques@grupopie.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: [PATCH 2.6] 6/7 replace net_sysctl_strdup by kstrdup
Message-Id: <20050131202952.52e1482c.davem@davemloft.net>
In-Reply-To: <1107228519.41fef7678e901@webmail.grupopie.com>
References: <1107228519.41fef7678e901@webmail.grupopie.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  1 Feb 2005 03:28:39 +0000
"" <pmarques@grupopie.com> wrote:

> This patch removes a strdup implmentation in the networking layer
> (net_sysctl_strdup), and updates it to use the kstrdup library function.
> 
> Signed-off-by: Paulo Marques <pmarques@grupopie.com>

If kstrdup() does in, I'm fine with this change.
net_sysctl_strdup() only exists because kstrdup() did
not.
