Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262161AbVC2Cz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbVC2Cz5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 21:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262162AbVC2Cz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 21:55:56 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:18388
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262161AbVC2Czv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 21:55:51 -0500
Date: Mon, 28 Mar 2005 18:54:08 -0800
From: "David S. Miller" <davem@davemloft.net>
To: ananth@in.ibm.com
Cc: wcohen@redhat.com, systemtap@sources.redhat.com, akpm@osdl.org,
       prasanna@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: kprobe_handler should  check pre_handler function
Message-Id: <20050328185408.4b0e215c.davem@davemloft.net>
In-Reply-To: <20050329023408.GA4847@in.ibm.com>
References: <424872C8.6080207@redhat.com>
	<20050329023408.GA4847@in.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Mar 2005 21:34:08 -0500
Ananth N Mavinakayanahalli <ananth@in.ibm.com> wrote:

> You are right. The check for pre_handler is needed and here is a patch
> against 2.6.12-rc1-mm3 that does this.

The sparc64 part looks just fine.
