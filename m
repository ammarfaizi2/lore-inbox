Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262549AbUCOMFl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 07:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262551AbUCOMFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 07:05:41 -0500
Received: from mail.zmailer.org ([62.78.96.67]:43538 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S262549AbUCOMFf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 07:05:35 -0500
Date: Mon, 15 Mar 2004 14:05:26 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: linux-kernel@vger.kernel.org
Subject: Yet another dead, and aplenty used DNS BL list...
Message-ID: <20040315120526.GW1653@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


$ dig any '*'.relays.monkeys.com

;; ANSWER SECTION:
*.relays.monkeys.com. IN  A    127.0.0.2
*.relays.monkeys.com. IN  TXT  "BLOCKED: http://www.monkeys.com/dnsbl/"


Right...   Poisoned.

I don't oppose use of DNS BLs per se, what I do find opposable is
people's lack of tracking of how their DNS BL is living at any given
moment.

The monkeys dataset announced end of service on 23rd of September 2003,
and I do find that their leniency of 4 months has been quite gracious
enough.  Read more at that web-page.

The free/public DNS BLs have limited lifespans, when using such, be
very carefull to track their status at least weekly, including end-of-
service announcements in their web-pages.

/Matti Aarnio   one of <postmaster at vger.kernel.org>
