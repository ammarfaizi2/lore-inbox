Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262775AbUCRROh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 12:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262795AbUCRROh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 12:14:37 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:44036 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S262775AbUCRRO0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 12:14:26 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Justin Piszcz" <jpiszcz@hotmail.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Linux Kernel Microcode Question
Date: Thu, 18 Mar 2004 09:13:37 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKMENKLCAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
In-Reply-To: <20040318165952.GA24328@redhat.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2055
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Thu, 18 Mar 2004 08:52:12 -0800
	(not processed: message from valid local sender)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  > Is it worth it?

> In most cases, yes.  It's zero cost. You don't waste RAM, as the
> microcode gets loaded into small RAM areas on the CPU that are
> otherwise unused.

	It is at least theoeretically possible that a microcode update might cause
an operation that's normally done very quickly (in dedicated hardware) to be
done by a slower path (microcode operations) to fix a bug in the dedicated
hardware that is very obscure and very unlikely to ever bother you. However,
I have never heard of even a single confirmed instance where this happened.

	DS


