Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbUDWVJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUDWVJu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 17:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbUDWVJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 17:09:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23230 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261426AbUDWVJt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 17:09:49 -0400
Date: Fri, 23 Apr 2004 14:09:13 -0700
From: "David S. Miller" <davem@redhat.com>
To: David Stevens <dlstevens@us.ibm.com>
Cc: weddy@grc.nasa.gov, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: TCP rto estimation patch
Message-Id: <20040423140913.5a7491b9.davem@redhat.com>
In-Reply-To: <OFE28EC49F.335C9D5D-ON88256E7F.0073BC2E-88256E7F.0073F700@us.ibm.com>
References: <20040423142445.GC501@grc.nasa.gov>
	<OFE28EC49F.335C9D5D-ON88256E7F.0073BC2E-88256E7F.0073F700@us.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Apr 2004 14:06:39 -0700
David Stevens <dlstevens@us.ibm.com> wrote:

> I believe "2" and "3" are the scale factors for the fixed-point 
> representation
> of the data, not the "alpha" and "beta" I remember from the estimator 
> paper.

That's correct.
