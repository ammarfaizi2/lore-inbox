Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030205AbWGaQNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbWGaQNi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 12:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbWGaQNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 12:13:38 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47269 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751285AbWGaQNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 12:13:36 -0400
Subject: Re: [2.6.18-rc2-mm1] libata ate one PATA channel
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tejun Heo <htejun@gmail.com>
Cc: "\"J.A." =?ISO-8859-1?Q?Magall=F3n=22?= <jamagallon@ono.com>,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <44CE2908.8080502@gmail.com>
References: <20060728134550.030a0eb8@werewolf.auna.net>
	 <44CD0E55.4020206@gmail.com> <20060731172452.76a1b6bd@werewolf.auna.net>
	 <44CE2908.8080502@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 31 Jul 2006 17:31:29 +0100
Message-Id: <1154363489.7230.61.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-08-01 am 01:00 +0900, ysgrifennodd Tejun Heo:
> These are patches #110-112.  Andrew, can you drop those patches for the 
> time being?  I'm working on integrating those into libata #upstream now. 

If you drop the host_set and tuning patches please drop all the PATA
stuff and my other patches out. I don't have time to field a second
batch of hundreds of "why has my drive stopped working, why is the speed
wrong" emails. 

It'll be easier just to work outside the -mm tree with all this
continued in/out random breakage if people are just going to say "drop
xyz patch" rather than actually specifying *what is actually wrong* and
getting me to fix the merge (Tejun that last one sentence is a hint ;))

Alan

