Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266627AbUJAUv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266627AbUJAUv0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 16:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266488AbUJAUso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 16:48:44 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:63911
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S266578AbUJAUow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 16:44:52 -0400
Date: Fri, 1 Oct 2004 13:43:22 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: jmorris@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reduce sha512_transform() stack usage, speedup
Message-Id: <20041001134322.237b8930.davem@davemloft.net>
In-Reply-To: <200410012338.11301.vda@port.imtp.ilyichevsk.odessa.ua>
References: <200410012231.51816.vda@port.imtp.ilyichevsk.odessa.ua>
	<200410012338.11301.vda@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Oct 2004 23:38:11 +0300
Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> wrote:

> WARNING: compile tested only.

You can't claim a "speed up" if you only compile test your
changes.  Neither can you expect us to apply patches in
such a case.

It's not that difficult to load the tcrypt module and make
sure all the tests for the module you're changing still
pass.
