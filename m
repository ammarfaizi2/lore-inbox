Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbTGHNXb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 09:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267298AbTGHNXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 09:23:31 -0400
Received: from tmi.comex.ru ([217.10.33.92]:49031 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S262499AbTGHNXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 09:23:30 -0400
X-Comment-To: Nikita Danilov
Cc: bzzz@tmi.comex.ru, linux-kernel@vger.kernel.org
Subject: Re: [RFC] parallel directory operations
From: Alex Tomas <bzzz@tmi.comex.ru>
To: linux-kernel@vger.kernel.org
Organization: HOME
Date: Tue, 08 Jul 2003 17:38:01 +0000
In-Reply-To: <16138.51005.54300.297204@laputa.namesys.com> (Nikita Danilov's
 message of "Tue, 8 Jul 2003 17:29:33 +0400")
Message-ID: <87vfucudfq.fsf@gw.home.net>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.3 (gnu/linux)
References: <87wuetukpa.fsf@gw.home.net.suse.lists.linux.kernel>
	<p73brw5qmxk.fsf@oldwotan.suse.de> <87of05ujfo.fsf@gw.home.net>
	<20030708134601.7992e64a.ak@suse.de> <87fzlhuif0.fsf@gw.home.net>
	<20030708141136.18e0034f.ak@suse.de> <877k6tuh5g.fsf@gw.home.net>
	<16138.49898.424148.525523@laputa.namesys.com>
	<874r1xuehd.fsf@gw.home.net>
	<16138.51005.54300.297204@laputa.namesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Nikita Danilov (ND) writes:


 ND> I am talking about "dynamic locks" taken in fs/namei.c. Have you
 ND> measured how your patch affects single-threaded case?

yep.

creation of 250K hardlinks by single process:
before: 0m16.913s
after:  0m17.423s

of course, it costs, but I believe some optimization are still
possible (proposed by Andi, at least)

thanks for review!


