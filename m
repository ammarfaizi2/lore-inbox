Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264658AbUGFWxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264658AbUGFWxx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 18:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264656AbUGFWxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 18:53:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12683 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264658AbUGFWxK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 18:53:10 -0400
Date: Tue, 6 Jul 2004 15:50:13 -0700
From: "David S. Miller" <davem@redhat.com>
To: John Heffner <jheffner@psc.edu>
Cc: netdev@oss.sgi.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix tcp_default_win_scale.
Message-Id: <20040706155013.32af8e13.davem@redhat.com>
In-Reply-To: <Pine.NEB.4.33.0407061751380.10143-100000@dexter.psc.edu>
References: <20040706133559.70b6380d.davem@redhat.com>
	<Pine.NEB.4.33.0407061751380.10143-100000@dexter.psc.edu>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jul 2004 17:55:12 -0400 (EDT)
John Heffner <jheffner@psc.edu> wrote:

> Another bit to addr to the firewall / window scale mess:  I remember from
> a while ago that the Cisco PIX firewalls would not allow a window scale of
> greater than 8.  I don't know if they've fixed this or not.  It seems
> like some sort of arbitrary limit.

In what manner did it deal with > 8 window scales?  By rewriting the option
or deleting the option entirely from the SYN or SYN+ACK packets?
