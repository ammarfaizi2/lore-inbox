Return-Path: <linux-kernel-owner+w=401wt.eu-S932097AbXAOXDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbXAOXDQ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 18:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbXAOXDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 18:03:16 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37223 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932097AbXAOXDQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 18:03:16 -0500
Date: Mon, 15 Jan 2007 23:14:52 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Olivier Galibert <galibert@pobox.com>
Cc: "Hack inc." <linux-kernel@vger.kernel.org>
Subject: Re: What does this scsi error mean ?
Message-ID: <20070115231452.3528bd32@localhost.localdomain>
In-Reply-To: <20070115214503.GA56952@dspnet.fr.eu.org>
References: <20070115171602.GA23661@dspnet.fr.eu.org>
	<20070115184540.2b3c4f78@localhost.localdomain>
	<20070115214503.GA56952@dspnet.fr.eu.org>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Both smart and the internal blade diagnostics say "everything is a-ok
> with the drive, there hasn't been any error ever except a bunch of
> corrected ECC ones, and no more than with a similar drive in another
> working blade".  Hence my initial post.  "Hardware error" is kinda
> imprecise, so I was wondering whether it was unexpected controller
> answer, detected transmission error, block write error, sector not
> found...  Is there a way to have more information?

Well the right place to look would indeed have been the SMART data
providing the drive didn't get into a state it couldn't update it.
Hardware error comes from the drive deciding something is wrong (or a
raid card faking it I guess). That covers everything from power
fluctuations and overheating through firmware consistency failures and
more.

If you pull the drive and test it in another box does it show the same ?
And what does a scsi verify have to say ?


Alan
