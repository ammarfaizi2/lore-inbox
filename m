Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262245AbUK0ESp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262245AbUK0ESp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 23:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbUK0D7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:59:34 -0500
Received: from zeus.kernel.org ([204.152.189.113]:42947 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262439AbUKZTah (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:30:37 -0500
Date: Thu, 25 Nov 2004 17:53:53 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 3/51: e820 table support
Message-ID: <20041125165352.GA476@openzaurus.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101292920.5805.198.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101292920.5805.198.camel@desktop.cunninghams>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The first of the 'real' candidates for merging.
> 
> This adds support for setting and clearing the Nosave status of pages
> based on the contents of the e820 table, and clearing Nosave for __init
> pages when they're freed.

I'd say that page that is both nosave and __init would be a bug.
But strategic BUG_ON() would be welcome...

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

