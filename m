Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262158AbUK0ESg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262158AbUK0ESg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 23:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbUK0D7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:59:43 -0500
Received: from zeus.kernel.org ([204.152.189.113]:42947 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262438AbUKZTag (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:30:36 -0500
Date: Thu, 25 Nov 2004 19:15:29 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 14/51: Disable page alloc failure message when suspending
Message-ID: <20041125181529.GE1417@openzaurus.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101294838.5805.245.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101294838.5805.245.camel@desktop.cunninghams>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> While eating memory, we will potentially trigger this a lot. We
> therefore disable the message when suspending.

You should only trigger this while eating memory, so *one* GFP_NOWARN should be
enough. And shrink_all_memory should fix it anyway.
				Pavel

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

