Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbVA1RLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbVA1RLk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 12:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbVA1RLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 12:11:40 -0500
Received: from ip67-155-213-211.z213-155-67.customer.algx.net ([67.155.213.211]:25202
	"EHLO noteshub.teal.com") by vger.kernel.org with ESMTP
	id S261195AbVA1RLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 12:11:38 -0500
Subject: Verify system io addresses
To: linux-kernel@vger.kernel.org
Message-ID: <OF9D8C9A4F.B7F39615-ON85256F97.005DDD20@teal.com>
From: Jeff.Fellin@rflelect.com
Date: Fri, 28 Jan 2005 12:10:51 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I want to develop a device driver that would allow access to board
registers and memory that is addressable
on the system bus.  The reason for this is to allow hardware developers to
access board registers while the system
is running to determine what is wrong with a board. The problem I'm having
is attempting to determine if an address
is addressable and would not cause a system panic when accessing. I'm
looking for functions similar to the
verify_access for user addresses, or if that is not available a method to
determine that an address fault in the
kernel is actually due to a bad board address being used.

The driver has a user program that allows the hardware developers to peek
and poke at address locations.
So it is possible for them to mistype the address.

Thank you in advance for your help.

Jeff Fellin
RFL Electronics
Jeff.Fellin@rflelect.com
973 334-3100, x 327

