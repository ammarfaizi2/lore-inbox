Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264444AbTLBXlD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 18:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264446AbTLBXlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 18:41:03 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:36252 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S264444AbTLBXlA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 18:41:00 -0500
Date: Tue, 2 Dec 2003 15:40:51 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: bill davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: libata in 2.4.24?
Message-ID: <20031202234051.GE4154@mis-mike-wstn.matchmail.com>
Mail-Followup-To: bill davidsen <davidsen@tmr.com>,
	linux-kernel@vger.kernel.org
References: <3FCB8312.3050703@rackable.com> <877k1f9e1g.fsf@stark.dyndns.tv> <bqj41c$drr$1@gatekeeper.tmr.com> <20031202230216.GB4154@mis-mike-wstn.matchmail.com> <bqj6k0$e2p$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bqj6k0$e2p$1@gatekeeper.tmr.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 02, 2003 at 11:18:24PM +0000, Bill Davidsen wrote:
> In article <20031202230216.GB4154@mis-mike-wstn.matchmail.com>,
> Mike Fedyk  <mfedyk@matchmail.com> wrote:
> | On Tue, Dec 02, 2003 at 10:34:20PM +0000, Bill Davidsen wrote:
> | > after each O_SYNC write, so that's probably not practical. Clearly the
> | > best solution is a full SCSI implementation over PATA/SATA, but that
> | > would eliminate some of the justification for SCSI devices at premium
> | > prices.
> | 
> | In many ways, that is exactly what SATA is. :)
> 
> Until multiple devices be string are available SATA will have logistical
> problems scaling. The small cable is an advantage running a few drives
> in a box, but a server with 40 drives or so would go from a cable bundle
> out the back, about 5cm by 1 cm, to a real bunch of those little round
> cables running everywhere. Certainly doable, but I think I'd name the
> server "Medusa" if I built it.
> 

Isn't this what SSCSI (Serial SCSI) will be doing also -- one drive one cable?

I'd imagine that you'd have one connection to the enclosure, and the entire
enclosure will look like a single drive.  I've heard of SCSI enclosures like
this (even ones that hold ide drives, but talk scsi to the host).

> I believe SATA-2 will address this, if I may believe what's projected
> for an unwritten standard.

There will probably be many ways to get around any issues that may come up
with SATA until SATA-2 comes out.
