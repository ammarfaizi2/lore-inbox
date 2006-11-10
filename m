Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946749AbWKJQPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946749AbWKJQPj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 11:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946746AbWKJQPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 11:15:39 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:12004 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1946747AbWKJQPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 11:15:38 -0500
Date: Fri, 10 Nov 2006 16:20:21 +0000
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Pavel Machek <pavel@ucw.cz>, Albert Cahalan <acahalan@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2048 CPUs [was: Re: New filesystem for Linux]
Message-Id: <20061110162021.504dc9e9.alan@lxorguk.ukuu.org.uk>
In-Reply-To: <Pine.LNX.4.64.0611101606090.20654@artax.karlin.mff.cuni.cz>
References: <787b0d920611041154l69db46abv4c8c467809ada57c@mail.gmail.com>
	<Pine.LNX.4.64.0611042332240.20974@artax.karlin.mff.cuni.cz>
	<20061107212614.GA6730@ucw.cz>
	<Pine.LNX.4.64.0611072328220.10497@artax.karlin.mff.cuni.cz>
	<20061107231456.GB7796@elf.ucw.cz>
	<Pine.LNX.4.64.0611081921170.5694@artax.karlin.mff.cuni.cz>
	<20061110090303.GB3196@elf.ucw.cz>
	<Pine.LNX.4.64.0611101606090.20654@artax.karlin.mff.cuni.cz>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Intel only guarantees that cmpxchg (or any other instruction) completes in 
> finite time, but it doesn't say anything about the result of it.

They don't even guarantee that... (hlt for example) or instructions SMM trapping into stuff that doesn't come back
 
</pedant>

Alan
