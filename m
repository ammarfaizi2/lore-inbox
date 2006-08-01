Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422640AbWHAHvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422640AbWHAHvn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 03:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161361AbWHAHvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 03:51:43 -0400
Received: from blinkenlights.ch ([62.202.0.18]:27091 "EHLO blinkenlights.ch")
	by vger.kernel.org with ESMTP id S1161350AbWHAHvm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 03:51:42 -0400
Date: Tue, 1 Aug 2006 09:51:41 +0200
From: Adrian Ulrich <reiser4@blinkenlights.ch>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: nate.diller@gmail.com, dlang@digitalinsight.com, matthias.andree@gmx.de,
       vonbrand@inf.utfsm.cl, ipso@snappymail.ca, reiser@namesys.com,
       lkml@lpbproductions.com, jeff@garzik.org, tytso@mit.edu,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: Solaris ZFS on Linux [Was: Re: the " 'official' point of view"
 expressed by kernelnewbies.org regarding reiser4 inclusion]
Message-Id: <20060801095141.5ec0b479.reiser4@blinkenlights.ch>
In-Reply-To: <20060801010215.GA24946@merlin.emma.line.org>
References: <20060731175958.1626513b.reiser4@blinkenlights.ch>
	<200607311918.k6VJIqTN011066@laptop13.inf.utfsm.cl>
	<20060731225734.ecf5eb4d.reiser4@blinkenlights.ch>
	<44CE7C31.5090402@gmx.de>
	<5c49b0ed0607311621i54f1c46fh9137f8955c9ea4be@mail.gmail.com>
	<Pine.LNX.4.63.0607311621360.14674@qynat.qvtvafvgr.pbz>
	<5c49b0ed0607311650j4b86d0c3h853578f58db16140@mail.gmail.com>
	<Pine.LNX.4.63.0607311651410.14674@qynat.qvtvafvgr.pbz>
	<5c49b0ed0607311705t1eb8fc6bs9a68a43059bfa91a@mail.gmail.com>
	<20060801010215.GA24946@merlin.emma.line.org>
Organization: Bluewin AG
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.20; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> suspect, particularly with 7200/min (s)ATA crap. 

Quoting myself (again):
>> A quick'n'dirty ZFS-vs-UFS-vs-Reiser3-vs-Reiser4-vs-Ext3 'benchmark'

Yeah, the test ran on a single SATA-Harddisk (quick'n'dirty).
I'm so sorry but i don't have access to a $$$ Raid-System at home. 

Anyway: The test shows us that Reiser4 performed very good on my
(common 0-8-15) hardware.


> sdparm --clear=WCE /dev/sda   # please.

How about using /dev/emcpower* for the next benchmark?

I mighty be able to re-run it in a few weeks if people are interested
and if i receive constructive suggestions (= Postmark parameters,
mkfs options, etc..)


Regards,
 Adrian

