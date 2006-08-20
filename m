Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbWHTTp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbWHTTp4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 15:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWHTTp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 15:45:56 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:16090
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751186AbWHTTpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 15:45:54 -0400
Date: Sun, 20 Aug 2006 12:46:05 -0700 (PDT)
Message-Id: <20060820.124605.71096208.davem@davemloft.net>
To: w@1wt.eu
Cc: ak@suse.de, solar@openwall.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH] getsockopt() early argument sanity checking
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060820101528.GE602@1wt.eu>
References: <20060819230532.GA16442@openwall.com>
	<200608201034.43588.ak@suse.de>
	<20060820101528.GE602@1wt.eu>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willy Tarreau <w@1wt.eu>
Date: Sun, 20 Aug 2006 12:15:28 +0200

> Others will consider it totally useless because it does not cover
> all cases, but I think it is against the general principle of
> precaution we try to apply in security.

Reading in a value from userspace twice for questionable
"security"  is just bogus.
