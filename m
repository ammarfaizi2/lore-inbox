Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262032AbULHFaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbULHFaN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 00:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbULHFaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 00:30:13 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:50609
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262030AbULHFaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 00:30:09 -0500
Date: Tue, 7 Dec 2004 21:28:17 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Mitchell Blank Jr <mitch@sfgoth.com>
Cc: kernel@linuxace.com, shemminger@osdl.org, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] fix select() for SOCK_RAW sockets
Message-Id: <20041207212817.1b74671b.davem@davemloft.net>
In-Reply-To: <20041207150834.GA75700@gaz.sfgoth.com>
References: <20041207003525.GA22933@linuxace.com>
	<20041207025218.GB61527@gaz.sfgoth.com>
	<20041207045302.GA23746@linuxace.com>
	<20041207054840.GD61527@gaz.sfgoth.com>
	<20041207150834.GA75700@gaz.sfgoth.com>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Dec 2004 07:08:34 -0800
Mitchell Blank Jr <mitch@sfgoth.com> wrote:

> Davem: I only tested that this doesn't break UDP; if it works for Phil and
> Stephen can verify that it doesn't break his bad-checksum UDP tests then
> please push it for 2.6.10.

Looks good Mitchell, patch applied.

Thanks.
