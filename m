Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264263AbUEIDNA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264263AbUEIDNA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 23:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264226AbUEIDNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 23:13:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52371 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264265AbUEIDM7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 23:12:59 -0400
Date: Sat, 8 May 2004 20:12:15 -0700
From: "David S. Miller" <davem@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: akpm@osdl.org, dipankar@in.ibm.com, manfred@colorfullife.com,
       davej@redhat.com, wli@holomorphy.com, linux-kernel@vger.kernel.org,
       maneesh@in.ibm.com
Subject: Re: dentry bloat.
Message-Id: <20040508201215.24f0d239.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0405081947290.1592@ppc970.osdl.org>
References: <409B1511.6010500@colorfullife.com>
	<20040508012357.3559fb6e.akpm@osdl.org>
	<20040508022304.17779635.akpm@osdl.org>
	<20040508031159.782d6a46.akpm@osdl.org>
	<Pine.LNX.4.58.0405081019000.3271@ppc970.osdl.org>
	<20040508120148.1be96d66.akpm@osdl.org>
	<Pine.LNX.4.58.0405081208330.3271@ppc970.osdl.org>
	<Pine.LNX.4.58.0405081216510.3271@ppc970.osdl.org>
	<20040508204239.GB6383@in.ibm.com>
	<20040508135512.15f2bfec.akpm@osdl.org>
	<20040508211920.GD4007@in.ibm.com>
	<20040508171027.6e469f70.akpm@osdl.org>
	<Pine.LNX.4.58.0405081947290.1592@ppc970.osdl.org>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


FWIW this patch does not change the dentry size on sparc64.
It's 256 bytes both before and after.  But of course the
inline string length is larger.

