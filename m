Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130092AbRAaAjk>; Tue, 30 Jan 2001 19:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131680AbRAaAja>; Tue, 30 Jan 2001 19:39:30 -0500
Received: from ping-ef-gw.ping.de ([62.72.90.14]:9750 "EHLO noefs.ping.de")
	by vger.kernel.org with ESMTP id <S130092AbRAaAjW>;
	Tue, 30 Jan 2001 19:39:22 -0500
Message-Id: <200101310038.BAA21051@noefs.ping.de>
Subject: Re: Multiple SCSI host adapters, naming of attached devices
In-Reply-To: <20010130224912.A388@kermit.wd21.co.uk> from Michael Pacey at "Jan
 30, 2001 10:49:12 pm"
To: Michael Pacey <michael@wd21.co.uk>
Date: Wed, 31 Jan 2001 01:38:39 +0100 (MET)
CC: linux-kernel@vger.kernel.org
From: Wolfgang Wegner <wolfgang@leila.ping.de>
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
> Given two host adapters each with 1 disk of ID 0, how do I tell Linux which
> is sda and which sdb?
[...]
which leads me to the question:
Is there any reason for the (IMHO stupid) "dynamic" naming of
SCSI devices (in contrast to e.g. IDE devices or the "physical"
device naming used in Solaris)?
It may be possible always maintaining the "right" order with
one SCSI chain, but as soon as there is a second bus, it is
really a pain. Is devfs the only solution?

Regards,
Wolfgang

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
