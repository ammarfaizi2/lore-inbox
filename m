Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161032AbWGZUSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161032AbWGZUSx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 16:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161031AbWGZUSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 16:18:53 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:8128 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161032AbWGZUSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 16:18:52 -0400
Subject: Re: 3ware disk latency?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: dean gaudet <dean@arctic.org>
Cc: Jan Kasprzak <kas@fi.muni.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0607260942110.22242@twinlark.arctic.org>
References: <20060710141315.GA5753@fi.muni.cz>
	 <Pine.LNX.4.64.0607260942110.22242@twinlark.arctic.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 26 Jul 2006 21:37:29 +0100
Message-Id: <1153946249.13509.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-07-26 am 09:52 -0700, ysgrifennodd dean gaudet:
> On Mon, 10 Jul 2006, Jan Kasprzak wrote:
> 
> > 	Does anybody experience the similar latency problems with
> > 3ware 95xx controllers? Thanks,
> 
> i think the 95xx is really bad at sharing its cache fairly amongst 
> multiple devices... i have a 9550sx-8lp with 3 exported units: a raid1, a 
> raid10 and a jbod.  i was zeroing the jbod with dd and it absolutely 
> destroyed the latency of the other two units.

Even on the older 3ware I found it neccessary to bump up the queue sizes
for the 3ware. There's a thread from about 6 months ago (maybe a bit
more) with Jeff Merkey included where it made a huge difference to his
performance playing with the parameters. Might be worth a scan through
the archive.

Alan

