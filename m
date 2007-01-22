Return-Path: <linux-kernel-owner+w=401wt.eu-S1751409AbXAVIio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbXAVIio (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 03:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbXAVIio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 03:38:44 -0500
Received: from aa011msr.fastwebnet.it ([85.18.95.71]:46149 "EHLO
	aa011msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409AbXAVIin (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 03:38:43 -0500
Date: Mon, 22 Jan 2007 09:38:23 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Tejun Heo <htejun@gmail.com>
Cc: Robert Hancock <hancockr@shaw.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       =?ISO-8859-15?B?Qmr2cm4=?= Steinbrink <B.Steinbrink@gmx.de>,
       Jens Axboe <jens.axboe@oracle.com>, Jeff Garzik <jeff@garzik.org>
Subject: Re: SATA exceptions triggered by XFS (since 2.6.18)
Message-ID: <20070122093823.1241be05@localhost>
In-Reply-To: <45B42569.6030902@gmail.com>
References: <20070121152932.6dc1d9fb@localhost>
	<20070121174023.68402ade@localhost>
	<45B3A392.6050609@shaw.ca>
	<20070121202552.14cc29fe@localhost>
	<45B42569.6030902@gmail.com>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.10.6; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jan 2007 11:46:01 +0900
Tejun Heo <htejun@gmail.com> wrote:

> > I don't know. It's a two years old ST380817AS.
> > 
> > # smartctl -a -d ata /dev/sda
> > 
> > smartctl version 5.36 [x86_64-pc-linux-gnu] Copyright (C) 2002-6 Bruce Allen
> > Home page is http://smartmontools.sourceforge.net/
> > 
> > === START OF INFORMATION SECTION ===
> > Model Family:     Seagate Barracuda 7200.7 and 7200.7 Plus family
> > Device Model:     ST380817AS
> 
> I'll blacklist it.  Thanks.

Ok. It will be better if someone else with the same HD could confirm.

It looks so strange that an HD that works fine, and should support NCQ,
have so big troubles that I can "freeze" it in less than a second by
using XFS (while with ext3 I cannot, or at least it's very hard).

-- 
	Paolo Ornati
	Linux 2.6.20-rc5 on x86_64
