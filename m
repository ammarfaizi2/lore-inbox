Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268329AbUHTQuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268329AbUHTQuK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 12:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268333AbUHTQuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 12:50:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33953 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268329AbUHTQuH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 12:50:07 -0400
Date: Fri, 20 Aug 2004 09:46:10 -0700
From: "David S. Miller" <davem@redhat.com>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: alexn@telia.com, miles.lane@comcast.net, linux-kernel@vger.kernel.org
Subject: Re: DTrace-like analysis possible with future Linux kernels?
Message-Id: <20040820094610.440646fe.davem@redhat.com>
In-Reply-To: <87acwp2a86.fsf@deneb.enyo.de>
References: <200408191822.48297.miles.lane@comcast.net>
	<87hdqyogp4.fsf@killer.ninja.frodoid.org>
	<87k6vu3bet.fsf@deneb.enyo.de>
	<1093008895.7824.11.camel@boxen>
	<87acwp2a86.fsf@deneb.enyo.de>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2004 15:46:33 +0200
Florian Weimer <fw@deneb.enyo.de> wrote:

> > One could quite easily hack up a tool to monitor I/O per process or
> > does it need to be very more precise?
> 
> It would be nice to obtain file names, too.

I bet you could even implement this quite simply as
a new special oprofile event.
