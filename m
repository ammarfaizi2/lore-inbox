Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268409AbUILBNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268409AbUILBNP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 21:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268410AbUILBNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 21:13:15 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:7833
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S268409AbUILBNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 21:13:14 -0400
Date: Sat, 11 Sep 2004 18:12:05 -0700
From: "David S. Miller" <davem@davemloft.net>
To: admin@wolfpaw.net
Cc: linux-kernel@vger.kernel.org, grsecurity@grsecurity.net,
       bugtraq@securityfocus.com
Subject: Re: Linux 2.4.27 SECURITY BUG - TCP Local (probable Remote) Denial
 of Service
Message-Id: <20040911181205.4202f0e0.davem@davemloft.net>
In-Reply-To: <004c01c49848$2608e180$0200a8c0@wolf>
References: <004c01c49848$2608e180$0200a8c0@wolf>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Close wait means the application locally has not closed
the file descriptor, yet the remote end has sent
a FIN.

This is %99 of the time an application bug.

But since you haven't provided much detail of the problem
nobody will ever know exactly what you're talking about.

Please, do me and everyone else here on this list a real huge
favor, don't post bug reports without all the details, you're
just wasting everyone's time.  If it's exploitable, even more
reason to post every single detail so we can work on a fix if
necessary as fast as possible.
