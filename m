Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbUL1SVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbUL1SVz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 13:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbUL1SVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 13:21:55 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:60590
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261185AbUL1SVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 13:21:54 -0500
Date: Tue, 28 Dec 2004 10:20:26 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Manuel Perez Ayala <mperaya@alcazaba.unex.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TG3 support broken on PPC (PowerMac G4)
Message-Id: <20041228102026.0ec40a5a.davem@davemloft.net>
In-Reply-To: <1104217668.41d10644a57f7@alcazaba.unex.es>
References: <1104217668.41d10644a57f7@alcazaba.unex.es>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Dec 2004 08:07:48 +0100
Manuel Perez Ayala <mperaya@alcazaba.unex.es> wrote:

> Disconnecting: Corrupted MAC on input.
> lost connection

That message is from ssh, and it indicates data corruption
on the TCP connection.

I have a similar report on x86_64 from Alan Cox.  What does
the kernel say when the module is loaded?  In particular
the lines from the kernel logs which describe the exact tg3
chip revision.
