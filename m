Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbTHXWDb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 18:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbTHXWDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 18:03:31 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:38795
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261325AbTHXWDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 18:03:30 -0400
Date: Mon, 25 Aug 2003 00:03:57 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: TeJun Huh <tejun@aratech.co.kr>
Cc: Stephan von Krawczynski <skraw@ithnet.com>, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org, zwane@linuxpower.ca
Subject: Re: Possible race condition in i386 global_irq_lock handling.
Message-ID: <20030824220357.GF1460@dualathlon.random>
References: <3F44FAF3.8020707@colorfullife.com> <20030821172721.GI29612@dualathlon.random> <20030821234824.37497c08.skraw@ithnet.com> <20030822011840.GA14540@atj.dyndns.org> <20030822162546.GQ29612@dualathlon.random> <20030824030651.GA13292@atj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030824030651.GA13292@atj.dyndns.org>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 24, 2003 at 12:06:51PM +0900, TeJun Huh wrote:
>  As now I know that test_and_set_bit() implies memory barrier,
> smb_mb__after_clear_bit() can be removed.  I'll make and post a patch

;) right

> which fixes this race and the bh race of the other thread.

thanks,

Andrea
