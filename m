Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272724AbTG1H43 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 03:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272725AbTG1H43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 03:56:29 -0400
Received: from tmi.comex.ru ([217.10.33.92]:29628 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S272724AbTG1H42 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 03:56:28 -0400
X-Comment-To: Andrew Morton
Cc: Marino Fernandez <mjferna@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Memory runs out fast with 2.6.0-test2 (and test1)
From: Alex Tomas <bzzz@tmi.comex.ru>
To: linux-kernel@vger.kernel.org
Organization: HOME
Date: Mon, 28 Jul 2003 12:11:08 +0000
In-Reply-To: <20030727205912.1bb4a635.akpm@osdl.org> (Andrew Morton's
 message of "Sun, 27 Jul 2003 20:59:12 -0700")
Message-ID: <87he56j1gj.fsf@gw.home.net>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.3 (gnu/linux)
References: <200307272117.23398.mjferna@yahoo.com>
	<20030727205912.1bb4a635.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


BTW, there is specific case. after umount all leaked buffer_heads get
removed from accounting. so, you won't find them in /proc/meminfo and
/proc/slabinfo. 

>>>>> Andrew Morton (AM) writes:

 AM> Please monitor /proc/meminfo and /proc/slabinfo, see if you can work out
 AM> where the memory has gone and post the results.


