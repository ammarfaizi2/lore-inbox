Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265874AbUFIUEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265874AbUFIUEf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 16:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265902AbUFIUEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 16:04:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13212 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265874AbUFIUEL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 16:04:11 -0400
Date: Wed, 9 Jun 2004 13:00:01 -0700
From: "David S. Miller" <davem@redhat.com>
To: Alex Williamson <alex.williamson@hp.com>
Cc: clameter@sgi.com, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Unaligned accesses in net/ipv4/netfilter/arp_tables.c:184
Message-Id: <20040609130001.37a88da1.davem@redhat.com>
In-Reply-To: <1086805676.4288.16.camel@tdi>
References: <Pine.LNX.4.58.0406091106210.21291@schroedinger.engr.sgi.com>
	<1086805676.4288.16.camel@tdi>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Jun 2004 12:27:56 -0600
Alex Williamson <alex.williamson@hp.com> wrote:

> http://marc.theaimsgroup.com/?l=netfilter-devel&m=107814727803971&w=2

How can you legitimately change this structure?  It's an exported
userland interface, if you change it all the applications will
stop working.
