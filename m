Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbUK0ESh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbUK0ESh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 23:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262178AbUK0D7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:59:46 -0500
Received: from zeus.kernel.org ([204.152.189.113]:42947 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262437AbUKZTaf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:30:35 -0500
Date: Thu, 25 Nov 2004 19:13:24 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 13/51: Disable highmem tlb flush for copyback.
Message-ID: <20041125181323.GD1417@openzaurus.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101294761.5805.241.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101294761.5805.241.camel@desktop.cunninghams>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> When we're making/restoring our atomic copy of the image, secondary
> processors are frozen. Trying an SMP call at that time could thus lead
> to deadlock. Secondary processors have 
Yes, and thats reason not to do SMP calls, not to hack SMP calling!
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

