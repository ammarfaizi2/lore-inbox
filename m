Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbVEaHpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbVEaHpM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 03:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbVEaHpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 03:45:12 -0400
Received: from oldconomy.demon.nl ([212.238.217.56]:28864 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S261287AbVEaHpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 03:45:05 -0400
Subject: Re: Playing with SATA NCQ
From: Erik Slagter <erik@slagter.name>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Michael Thonke <iogl64nx@gmail.com>, Mark Lord <liml@rtr.ca>
In-Reply-To: <429B7550.20309@pobox.com>
References: <20050526140058.GR1419@suse.de>
	 <1117382598.4851.3.camel@localhost.localdomain>
	 <4299F47B.5020603@gmail.com>
	 <1117387591.4851.17.camel@localhost.localdomain> <429A58F4.3040308@rtr.ca>
	 <1117438192.4851.29.camel@localhost.localdomain> <429B56CA.5080803@rtr.ca>
	 <1117477364.3108.2.camel@localhost.localdomain>
	 <429B6060.1010806@pobox.com>
	 <1117483420.3108.8.camel@localhost.localdomain>  <429B7550.20309@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 31 May 2005 09:44:57 +0200
Message-Id: <1117525497.3108.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-30 at 16:19 -0400, Jeff Garzik wrote:
> >>>I must have been fooled by the FC3 setup disk that handed it libata,  I
> >>>didn't know libata also handles pata, then.
> >>libata software supports PATA, but no distribution ships with libata 
> >>PATA support enabled (nor should they!).
> > In that case FC3 is not a distribution?!
> >>There are a few unusual cases with combined mode where libata will 
> >>support PATA, but those are rare.
> > ich6/piix :-)
> 
> Under PATA your devices should be showing up at /dev/hdX.
> If this is not the case, please report a bug.

Okay, just to be sure before I file an official bug report:

kernel 2.6.12-rc5-git4
libata enabled (with atapi enabled, but that doesn't influence the
"harddisk" behaviour)
all ide stuff disabled
ICH6-M
Fujitsu MHT2080A harddisk (apparently PATA)
Disk shows up as /dev/sda

I don't mind, though.
