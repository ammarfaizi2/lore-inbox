Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262086AbUJZDwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbUJZDwv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 23:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbUJZDwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 23:52:46 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:43741
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262156AbUJZDtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 23:49:20 -0400
Date: Mon, 25 Oct 2004 20:41:47 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Werner Almesberger <wa@almesberger.net>
Cc: hch@lst.de, davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove dead tcp exports
Message-Id: <20041025204147.667ee2b1.davem@davemloft.net>
In-Reply-To: <20041026000710.D3841@almesberger.net>
References: <20041024134309.GB20267@lst.de>
	<20041026000710.D3841@almesberger.net>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2004 00:07:10 -0300
Werner Almesberger <wa@almesberger.net> wrote:

> Wheee, you had me scared for a moment. But indeed, not even tcpcp
> (tcpcp.sf.net) uses any of these. But I kind of wonder how you
> determine they're "dead" ?

There are scripts which build everything as possible as modules
then greps the symbol tables of the object files to see which
symbols exported by the kernel are actually used.
