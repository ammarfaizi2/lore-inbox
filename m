Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967399AbWLDVsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967399AbWLDVsV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 16:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967405AbWLDVsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 16:48:21 -0500
Received: from [81.2.110.250] ([81.2.110.250]:33787 "EHLO lxorguk.ukuu.org.uk"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S967399AbWLDVsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 16:48:21 -0500
Date: Mon, 4 Dec 2006 21:53:27 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jeff@garzik.org>
Cc: Thomas Meyer <thomas@m3y3r.de>, linux-kernel@vger.kernel.org
Subject: Re: ata_piix multithreaded device probes breaks detection of SCSI
 device
Message-ID: <20061204215327.343cc81f@localhost.localdomain>
In-Reply-To: <45748984.2080006@garzik.org>
References: <4574865A.6030508@m3y3r.de>
	<45748984.2080006@garzik.org>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Dec 2006 15:48:04 -0500
Jeff Garzik <jeff@garzik.org> wrote:

> Thomas Meyer wrote:
> > head: d916faace3efc0bf19fe9a615a1ab8fa1a24cd93
> > 
> > Here a sequential probe, that boots fine:
> 
> Known problem, unfortunately, for a -great- many drivers.
> 
> Please turn off this option until the authors fix it.

I've aksed Linus to disable it for IDE (locking not safe) and Watchdog
(link order dependancy) already, really it has so many && !FOO it should
be removed and buried for now.

