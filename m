Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261633AbVCNB6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261633AbVCNB6E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 20:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbVCNB6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 20:58:04 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:17381
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261633AbVCNB6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 20:58:00 -0500
Date: Sun, 13 Mar 2005 17:56:57 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
       wli@holomorphy.com
Subject: Re: [BUG?] Signedness of __kernel_nlink_t on Sparc?
Message-Id: <20050313175657.44cb932b.davem@davemloft.net>
In-Reply-To: <bbcd3873d9324ce185dc9eaf146ef741@mac.com>
References: <bbcd3873d9324ce185dc9eaf146ef741@mac.com>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Mar 2005 19:21:09 -0500
Kyle Moffett <mrmacman_g4@mac.com> wrote:

> In include/asm-sparc/types.h, __kernel_nlink_t is signed, whereas on 
> all the
> other architectures it is unsigned.  Is this intentional, or a bug?

Intentional, in order to match SunOS.  Unfortunately this is pretty
much unchangable.
