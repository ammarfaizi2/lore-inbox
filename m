Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262416AbUKLAGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbUKLAGK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 19:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262246AbUKKW4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 17:56:30 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:48824
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262411AbUKKWtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 17:49:35 -0500
Date: Thu, 11 Nov 2004 14:36:23 -0800
From: "David S. Miller" <davem@davemloft.net>
To: David Howells <dhowells@redhat.com>
Cc: akpm@osdl.org, arnd@arndb.de, jbarnes@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix usage of setup_arg_pages() in IA64, MIPS, S390 and
 Sparc64
Message-Id: <20041111143623.05f1d92a.davem@davemloft.net>
In-Reply-To: <2555.1100085859@redhat.com>
References: <2555.1100085859@redhat.com>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Nov 2004 11:24:19 +0000
David Howells <dhowells@redhat.com> wrote:

> The attached patch fixes the usage of setup_arg_pages() in the IA64, MIPS,
> S390 and Sparc64 arches. This function now takes an extra parameter: the
> initial top of stack. This is useful in uClinux when there's no fixed location
> to which the stack pointer can be initialised.

The sparc64 part looks perfectly fine to me.
