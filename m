Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265139AbUEYWQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265139AbUEYWQy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 18:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265158AbUEYWOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 18:14:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2703 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265176AbUEYWMn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 18:12:43 -0400
Date: Tue, 25 May 2004 15:12:02 -0700
From: "David S. Miller" <davem@redhat.com>
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, ultralinux@vger.kernel.org
Subject: Re: [PATCH 3/4] Consolidate sys32_select
Message-Id: <20040525151202.58010d51.davem@redhat.com>
In-Reply-To: <1085522532.969.91.camel@tux.rsn.bth.se>
References: <200404161800.22367.arnd@arndb.de>
	<200404161805.55224.arnd@arndb.de>
	<1085522532.969.91.camel@tux.rsn.bth.se>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just fix the code to use compat_ptr().  That's what we created
that macro for :-)

