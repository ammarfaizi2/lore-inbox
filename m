Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267259AbUG1Pwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267259AbUG1Pwp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 11:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267253AbUG1PwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 11:52:01 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51178 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267252AbUG1PuI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 11:50:08 -0400
Date: Wed, 28 Jul 2004 08:47:16 -0700
From: "David S. Miller" <davem@redhat.com>
To: Florian Lohoff <flo@rfc822.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at net/core/skbuff.c:104
Message-Id: <20040728084716.7521fd88.davem@redhat.com>
In-Reply-To: <20040728095757.GA602@paradigm.rfc822.org>
References: <20040728095757.GA602@paradigm.rfc822.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jul 2004 11:57:57 +0200
Florian Lohoff <flo@rfc822.org> wrote:

> 
> bug with 2.6.7 (vanilla) - while tracepath6 - Only interfaces are lo
> and eth0 (eepro100) - ipv6 address via radv - Host is dual-stacked.
> gcc is a Debian/sarge 3.3.3

Well known bug in ipv6 fragmentation, fixed in current
2.6.8-rcX kernels.
