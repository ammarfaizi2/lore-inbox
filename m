Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263309AbTDNOjM (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 10:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263333AbTDNOjM (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 10:39:12 -0400
Received: from pizda.ninka.net ([216.101.162.242]:30692 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263309AbTDNOjL (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 10:39:11 -0400
Date: Mon, 14 Apr 2003 07:44:20 -0700 (PDT)
Message-Id: <20030414.074420.131780541.davem@redhat.com>
To: jmorris@intercode.com.au
Cc: chris@wirex.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove __sk_filter
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Mutt.LNX.4.44.0304150047230.4971-100000@blackbird.intercode.com.au>
References: <20030413225458.A20174@figure1.int.wirex.com>
	<Mutt.LNX.4.44.0304150047230.4971-100000@blackbird.intercode.com.au>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: James Morris <jmorris@intercode.com.au>
   Date: Tue, 15 Apr 2003 00:48:17 +1000 (EST)

   On Sun, 13 Apr 2003, Chris Wright wrote:
   
   > Now that CONFIG_FILTER was nuked, the __sk_filter helper can be collapsed
   > back into sk_filter.  This eliminates bypassing the security hook by
   > using the wrong part of the api.
   
   Good thinking, thanks.
   
Applied, thanks.
