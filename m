Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261716AbULJBKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbULJBKh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 20:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbULJBKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 20:10:36 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:52678
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261716AbULJBKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 20:10:31 -0500
Date: Thu, 9 Dec 2004 17:08:02 -0800
From: "David S. Miller" <davem@davemloft.net>
To: "Zou, Nanhai" <nanhai.zou@intel.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, tony.luck@intel.com,
       ak@suse.de, ralf@linux-mips.org, paulus@au.ibm.com,
       schwidefsky@de.ibm.com
Subject: Re: [Compatibilty patch] sigtimedwait
Message-Id: <20041209170802.7820ef02.davem@davemloft.net>
In-Reply-To: <894E37DECA393E4D9374E0ACBBE7427013C9FF@pdsmsx402.ccr.corp.intel.com>
References: <894E37DECA393E4D9374E0ACBBE7427013C9FF@pdsmsx402.ccr.corp.intel.com>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Dec 2004 08:40:57 +0800
"Zou, Nanhai" <nanhai.zou@intel.com> wrote:

> But I can't put a
> #ifdef __LITTLE_ENDIAN 
> here, 
> Because 
> only MIPS does the byte swapping in little endian mode.
> X86_64 and ia64 does not.

Good point.  Perhaps we can turn this into a cleaner looking
macro name that gets set in include/asm/compat.h
