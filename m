Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbUCSUzO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 15:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbUCSUzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 15:55:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:22985 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261184AbUCSUzH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 15:55:07 -0500
Date: Fri, 19 Mar 2004 12:55:05 -0800
From: "David S. Miller" <davem@redhat.com>
To: "Richard A. Hogaboom" <hogaboom@ll.mit.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Multicast reception fail when setsockopt() used to set
 SO_RCVBUF to small.
Message-Id: <20040319125505.4b1e7b1b.davem@redhat.com>
In-Reply-To: <1079728843.30591.19.camel@capella>
References: <1079728843.30591.19.camel@capella>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2004 15:40:44 -0500
"Richard A. Hogaboom" <hogaboom@ll.mit.edu> wrote:

> See attached bug.report file and example code files.

Yes, if you set SO_RCVBUF too small, you will not receive packets if
they are large enough.

There is nothing multicast specific about this behavior, and it is
correct behavior as well.
