Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270756AbTHJW43 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 18:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270757AbTHJW43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 18:56:29 -0400
Received: from colin2.muc.de ([193.149.48.15]:30468 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S270756AbTHJW42 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 18:56:28 -0400
Date: 11 Aug 2003 00:56:25 +0200
Date: Mon, 11 Aug 2003 00:56:25 +0200
From: Andi Kleen <ak@colin2.muc.de>
To: Simon Garner <sgarner@expio.co.nz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MSI K8D-Master - GART error 3
Message-ID: <20030810225625.GA41619@colin2.muc.de>
References: <gC1o.2gU.5@gated-at.bofh.it> <m3k79t7ykk.fsf@averell.firstfloor.org> <028101c35aea$d2753690$0401a8c0@SIMON> <20030805134241.GA63394@colin2.muc.de> <003e01c35f91$08227b40$0401a8c0@SIMON>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003e01c35f91$08227b40$0401a8c0@SIMON>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 10:43:57AM +1200, Simon Garner wrote:
> These suggest it's just reporting ECC corrections. Why would it do this

Yep. You have faulty DIMMs, consider replacing them.

> exactly every 30 seconds? (or is that just the reporting interval?)

The interval timer checking for "silent" MCEs runs every 30s.

You can change that by booting with mce=<number>   then it will run 
each number seconds. 0 should turn it off.

-Andi

