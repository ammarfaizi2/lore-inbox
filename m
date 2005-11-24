Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbVKXP0B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbVKXP0B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 10:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbVKXP0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 10:26:01 -0500
Received: from [81.2.110.250] ([81.2.110.250]:63720 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751312AbVKXP0A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 10:26:00 -0500
Subject: Re: S.M.A.R.T. command passthru to Firewire devices
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bernd Bartmann <bernd.bartmann@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6c18a4f0511240601i5860f724rff4db0c1b1fdca1e@mail.gmail.com>
References: <6c18a4f0511240601i5860f724rff4db0c1b1fdca1e@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 24 Nov 2005 15:58:37 +0000
Message-Id: <1132847917.13095.115.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-11-24 at 15:01 +0100, Bernd Bartmann wrote:
> When I try to run "smartctl -a /dev/sdb" it tells me that "Device does
> not support SMART". /dev/sdb is a normal hdd in an external firewire
> enclosure. To me this looks like the firewire SCSI layer does not
> support the passthru of the S.M.A.R.T. commands. Or is there any other
> way to query the S.M.A.R.T. status of an hdd attached via Firewire?

If it takes an ATA drive then you will probably be seeing the fact that
most firewire<->ATA convertor units don't support SMART so don't offer
it over their SCSI interface.


