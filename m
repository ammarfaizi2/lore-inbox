Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269651AbUHZVOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269651AbUHZVOM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 17:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269661AbUHZVLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 17:11:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2232 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269659AbUHZVGr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 17:06:47 -0400
Date: Thu, 26 Aug 2004 14:06:37 -0700
From: "David S. Miller" <davem@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: thomasz@hostmaster.org, linux-kernel@vger.kernel.org
Subject: Re: netfilter IPv6 support
Message-Id: <20040826140637.336c4d10.davem@redhat.com>
In-Reply-To: <412E4740.3090807@pobox.com>
References: <1093546367.3497.23.camel@hostmaster.org>
	<412E4740.3090807@pobox.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2004 16:25:36 -0400
Jeff Garzik <jgarzik@pobox.com> wrote:

> As Andi puts it, there is no infinite hash.

Using hash tables would be the problem :-)

Longest matching prefix lookup algorithms are a well researched area.
One we have not taken advantage of much at all.  This is more than
evident in our routing and netfilter code and I'm working to do
something about it. :-)
