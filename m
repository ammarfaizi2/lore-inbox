Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267089AbTGTNQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 09:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267123AbTGTNQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 09:16:57 -0400
Received: from rth.ninka.net ([216.101.162.244]:27587 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S267089AbTGTNQ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 09:16:56 -0400
Date: Sun, 20 Jul 2003 06:31:37 -0700
From: "David S. Miller" <davem@redhat.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: ak@muc.de, linas@austin.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: KDB in the mainstream 2.4.x kernels?
Message-Id: <20030720063137.3b0f2e14.davem@redhat.com>
In-Reply-To: <1681.1058705718@ocs3.intra.ocs.com.au>
References: <m3smp3y38y.fsf@averell.firstfloor.org>
	<1681.1058705718@ocs3.intra.ocs.com.au>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jul 2003 22:55:18 +1000
Keith Owens <kaos@ocs.com.au> wrote:

> i386 provides no unwind data

We could tell gcc to emit dwarf2 unwind tables on x86 for debugging
kernel builds.
