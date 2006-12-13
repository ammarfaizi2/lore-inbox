Return-Path: <linux-kernel-owner+w=401wt.eu-S964871AbWLMLY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbWLMLY7 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 06:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbWLMLY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 06:24:58 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51181 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S964855AbWLMLY5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 06:24:57 -0500
Date: Wed, 13 Dec 2006 11:32:48 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Cc: "Sergei Shtylyov" <sshtylyov@ru.mvista.com>, akpm@osdl.org,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc1] Toshiba TC86C001 IDE driver
Message-ID: <20061213113248.06372806@localhost.localdomain>
In-Reply-To: <58cb370e0612121709x41270fb2p20280cc1edc9c533@mail.gmail.com>
References: <200612130148.34539.sshtylyov@ru.mvista.com>
	<20061212234145.557cb035@localhost.localdomain>
	<58cb370e0612121709x41270fb2p20280cc1edc9c533@mail.gmail.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Waste of space having a busproc routine. The maintainer removed all the
> > usable hotplug support from old IDE so this might as well be dropped.
> 
> I took over IDE when hotplug was already broken (late 2.5), moreover IDE
> hotplug support has been always a quick hack according to its original author...
> I remember your great efforts to fix it but unfortunately they
> depended on executing
> ioctls on non-existing devices which made them depend on layering
> violation in 2.6,

Bart, I'm really not interested in a 500 email rehash of the fact you
chose to refuse the hotplug support (that was working) for 2.6.x. You
did, the world has moved on, and there is no point putting a busproc
function in that driver.

Do something useful. Send a patch to make Sergei the IDE maintainer as
he's doing all the IDE stuff these days.

