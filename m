Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbUCWDsE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 22:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbUCWDsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 22:48:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:13445 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261919AbUCWDsC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 22:48:02 -0500
Date: Mon, 22 Mar 2004 19:47:59 -0800
From: "David S. Miller" <davem@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: Issues with /proc/bus/pci
Message-Id: <20040322194759.7a38ffe9.davem@redhat.com>
In-Reply-To: <1080009609.23717.81.camel@gaston>
References: <1080007613.22212.61.camel@gaston>
	<20040322183126.16fe76cc.davem@redhat.com>
	<1080009609.23717.81.camel@gaston>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2004 13:40:11 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> What do you think ?

Ok, it does sound like we need something else.

Another idea is to always at least provide a "virtual" host
bridge on these weird platforms you mention.  You control
the PCI config space etc. operations, so you could handle
the virtual host bridge correctly right?
