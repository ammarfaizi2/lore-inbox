Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbVJITno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbVJITno (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 15:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbVJITnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 15:43:43 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:59623 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751146AbVJITnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 15:43:42 -0400
Date: Sun, 9 Oct 2005 12:01:00 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Coywolf Qi Hunt <coywolf@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [q] how to make sure a process is not on CPU?
Message-ID: <20051009100100.GA11389@openzaurus.ucw.cz>
References: <2cd57c900510072045m6949b621udfc9cf99a7708a75@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cd57c900510072045m6949b621udfc9cf99a7708a75@mail.gmail.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'm trying to manipulate a process, I must make sure not only the
> process won't go away under me, also it is not on CPU, and it'll
> return from schedule() at lease once.
> 
> Any thoughts?

See kernel/power/process.c
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

