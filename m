Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261860AbUKCUTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbUKCUTR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 15:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbUKCUTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 15:19:17 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:42701
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261860AbUKCUTL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 15:19:11 -0500
Date: Wed, 3 Nov 2004 12:08:48 -0800
From: "David S. Miller" <davem@davemloft.net>
To: yoshfuji@linux-ipv6.org
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       akpm@osdl.org, yoshfuji@linux-ipv6.org
Subject: Re: IPv6 dead in -bk11
Message-Id: <20041103120848.632e8fee.davem@davemloft.net>
In-Reply-To: <20041104.012128.51410945.yoshfuji@linux-ipv6.org>
References: <20041102.225343.06193184.yoshfuji@linux-ipv6.org>
	<4187A4E3.8010600@pobox.com>
	<20041103.012923.102810732.yoshfuji@linux-ipv6.org>
	<20041104.012128.51410945.yoshfuji@linux-ipv6.org>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Nov 2004 01:21:28 +0900 (JST)
YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org> wrote:

> In article <20041103.012923.102810732.yoshfuji@linux-ipv6.org> (at Wed, 03 Nov 2004 01:29:23 +0900 (JST)), YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org> says:
> 
> > So... I guess that kernel failed to add "default route" on receipt of RA.
> > Right?
> :
> 
> Sorry, this bug was introduced by my changeset:
> <http://linux.bkbits.net:8080/linux-2.5/cset@417dca81tJ4RRAxhWTbn0p6hI-1XIQ>.
> 
> David, this should fix the issue.

Patch applied, thanks for tracking down and fixing this bug.
