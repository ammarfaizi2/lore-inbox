Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265112AbTFUJdt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 05:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265113AbTFUJds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 05:33:48 -0400
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:41996 "EHLO
	krusty.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S265112AbTFUJds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 05:33:48 -0400
Date: Sat, 21 Jun 2003 11:47:48 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: "'lkml (linux-kernel@vger.kernel.org)'" 
	<linux-kernel@vger.kernel.org>
Subject: Re: AIC7(censored) card gone wild?
Message-ID: <20030621094748.GB4560@merlin.emma.line.org>
Mail-Followup-To: "'lkml (linux-kernel@vger.kernel.org)'" <linux-kernel@vger.kernel.org>
References: <A46BBDB345A7D5118EC90002A5072C780E040C95@orsmsx116.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C780E040C95@orsmsx116.jf.intel.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jun 2003, Perez-Gonzalez, Inaky wrote:

> So I wonder, what does that error mean? SCSI1 has attached a 
> CDRW (Sony Yamaha CDRW 8/4/24) but now it doesn't show up 
> anymore (and so, I cannot get the model). .

The first step towards finding that out is power cycling (shut down,
switch off for a minute, then start up again) or physically
disconnecting the Yamaha drive (if it's Yamaha).

I've seen Adaptecs fuss and fight with Yamahas more than once --
although in Linux 2.2 and early 2.4 times -- and Yamahas have the nasty
habit of locking up until the next power cycle when something goes
wrong.

> Could it mean by SCSI Adapter is hosed? or my CDRW drive?

It might be either, I'd suspect the CDRW first unless I had information
that suggests otherwise.

Try to find out.

-- 
Matthias Andree
