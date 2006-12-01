Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936480AbWLALvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936480AbWLALvd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 06:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936482AbWLALvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 06:51:33 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:2793 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S936480AbWLALvc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 06:51:32 -0500
Date: Fri, 1 Dec 2006 11:58:10 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: ron moncreiff <rmoncreiff@cruzers.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: trying pata_ali in 2.6.19
Message-ID: <20061201115810.55a4b66a@localhost.localdomain>
In-Reply-To: <456FC859.9070709@cruzers.com>
References: <456FC859.9070709@cruzers.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2006 22:14:49 -0800
ron moncreiff <rmoncreiff@cruzers.com> wrote:

> // I have tried out the new pata options in the 2.6.19 kernel and had 
> some problems. //
> // So here's the skinny. I am using the asrock 939dual - sataII mobo. 
> lspci reports //
> // the IDE interface thus: //

As you've no doubt noticed it isn't supposed to oops. Can you send me an
lspci -vxx of your system and in the mean time I will go and stare at the
code and see what is going on.

> // declarations (definitions ?) that seem to reference various revisions 
> of the chip. Mine is a c7 and there's no //
> // structure for that one. Could this be the problem?

C7 is quite new but the info blocks cover ranges of versions not specific
versions. It shouldn't be the cause but...

Alan
