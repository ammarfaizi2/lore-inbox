Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbUJYGEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbUJYGEP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 02:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbUJYGEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 02:04:14 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:45009
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261509AbUJYGEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 02:04:05 -0400
Date: Sun, 24 Oct 2004 22:57:00 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [NET]: TSO requires SG, enforce this at device registry.
Message-Id: <20041024225700.4a22a968.davem@davemloft.net>
In-Reply-To: <417C9431.6030505@pobox.com>
References: <200410221715.i9MHFlIu021927@hera.kernel.org>
	<417C9431.6030505@pobox.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2004 01:50:41 -0400
Jeff Garzik <jgarzik@pobox.com> wrote:

> 1) Given current driver implementations of ethtool ioctls, sysadmin is 
> free to create a combination of bits that are IMHO a bug.  One can argue 
> that this is an extension of "root can shoot himself in the foot", so 
> who knows.

I made a followon posting proposing ethtool changes which
would enforce the rules there too, did you see it?
