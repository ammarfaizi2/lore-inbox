Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbVCONxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVCONxi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 08:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbVCONxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 08:53:38 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:38846 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S261242AbVCONxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 08:53:35 -0500
Date: Tue, 15 Mar 2005 14:48:50 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Paul <set@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Repeatable IDE Oops for 2.6.11 (ide-scsi vs ide-cdrom)
In-Reply-To: <1110892926.17740.169.camel@localhost.localdomain>
Message-ID: <Pine.GSO.4.62.0503151445160.4218@mion.elka.pw.edu.pl>
References: <20050314065508.GA7974@squish.home.loc> 
 <1110822016.15927.136.camel@localhost.localdomain> 
 <Pine.GSO.4.62.0503150911540.17649@mion.elka.pw.edu.pl>
 <1110892926.17740.169.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 Mar 2005, Alan Cox wrote:

> On Maw, 2005-03-15 at 08:19, Bartlomiej Zolnierkiewicz wrote:
>> On Mon, 14 Mar 2005, Alan Cox wrote:
>> Locking is fixed in ide-dev-2.6 tree
>> (at the moment seem to be dropped from -mm?).
>
> Excellent - I'm looking forward to dropping the -ac IDE locking patches

There is still one thing TODO:

* fixing device drivers to refcount driver specific /proc/ide/ entries
   (infrastructure is in-place now)

so don't drop your locking patches yet. :-)
