Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262155AbUJZFAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262155AbUJZFAQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 01:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbUJZFAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 01:00:13 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:59870
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262062AbUJZE76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 00:59:58 -0400
Date: Mon, 25 Oct 2004 21:52:16 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Lee Revell <rlrevell@joe-job.com>
Cc: wa@almesberger.net, hch@lst.de, davem@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove dead tcp exports
Message-Id: <20041025215216.54b362f9.davem@davemloft.net>
In-Reply-To: <1098765665.9404.5.camel@krustophenia.net>
References: <20041024134309.GB20267@lst.de>
	<20041026000710.D3841@almesberger.net>
	<20041025204147.667ee2b1.davem@davemloft.net>
	<1098765665.9404.5.camel@krustophenia.net>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2004 00:41:05 -0400
Lee Revell <rlrevell@joe-job.com> wrote:

> Is this really a compelling reason to remove them?  For example ALSA
> provides an API for driver writers, just because a certain function
> happens not to be used by any does not mean is never will be or that it
> should not.

These are actually TCP internals, not a "well defined driver API"
as ALSA defines.
