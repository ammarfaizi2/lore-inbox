Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267554AbUH0UKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267554AbUH0UKs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 16:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267370AbUH0UJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 16:09:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62654 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267466AbUH0T4G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 15:56:06 -0400
Date: Fri, 27 Aug 2004 12:55:33 -0700
From: "David S. Miller" <davem@redhat.com>
To: Frank van Maarseveen <frankvm@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TCP listen()/accept() bug for unbound sockets?
Message-Id: <20040827125533.462b32dd.davem@redhat.com>
In-Reply-To: <20040827095640.GA27286@janus>
References: <20040827095640.GA27286@janus>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Aug 2004 11:56:40 +0200
Frank van Maarseveen <frankvm@xs4all.nl> wrote:

> is this defined behavior?

Yep, we auto-bind the socket for you.
