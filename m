Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269240AbUJFPBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269240AbUJFPBp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 11:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269282AbUJFPBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 11:01:45 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:60050
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S269240AbUJFPBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 11:01:43 -0400
Date: Wed, 6 Oct 2004 08:01:04 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Joris van Rantwijk <joris@eljakim.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-Id: <20041006080104.76f862e6.davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.58.0410061616420.22221@eljakim.netsystem.nl>
References: <Pine.LNX.4.58.0410061616420.22221@eljakim.netsystem.nl>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Oct 2004 16:52:27 +0200 (CEST)
Joris van Rantwijk <joris@eljakim.nl> wrote:

> My understanding of POSIX is limited, but it seems to me that a read call
> must never block after select just said that it's ok to read from the
> descriptor. So any such behaviour would be a kernel bug.

There is no such guarentee.
