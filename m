Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262396AbUBXSsQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 13:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262390AbUBXSsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 13:48:16 -0500
Received: from mx1.redhat.com ([66.187.233.31]:25486 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262396AbUBXSr0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 13:47:26 -0500
Date: Tue, 24 Feb 2004 10:47:18 -0800
From: "David S. Miller" <davem@redhat.com>
To: Ron Peterson <rpeterso@mtholyoke.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: network / performance problems
Message-Id: <20040224104718.26059b7b.davem@redhat.com>
In-Reply-To: <Pine.OSF.4.21.0402241330410.320699-100000@mhc.mtholyoke.edu>
References: <20040224102208.4fd285e3.davem@redhat.com>
	<Pine.OSF.4.21.0402241330410.320699-100000@mhc.mtholyoke.edu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hmmm, I wonder if the connection tracking tables are simply never shrinking.

Can you get some kernel profiles when the problem hits?  If you don't know how
to do this, it's got to be documented somewhere and I'm sure someone can point
you at how to do it.

I bet we'll see netfilter at the top of the profiles or something like that.
