Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280991AbRKOVwT>; Thu, 15 Nov 2001 16:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281094AbRKOVwK>; Thu, 15 Nov 2001 16:52:10 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:50960 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280991AbRKOVwH>; Thu, 15 Nov 2001 16:52:07 -0500
Subject: Re: Problem with 2.4.14 mounting i2o device as root device Adaptec 3200
To: michael@wizard.ca (Michael Peddemors)
Date: Thu, 15 Nov 2001 21:58:55 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1005861234.9918.806.camel@mistress> from "Michael Peddemors" at Nov 15, 2001 01:53:54 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E164UX9-0001mn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is anyone successfully using 2.4.14 on an Adaptec 3200s controller?
> This could be a PCI issue, because just we see a lot of interrrupt
> activity on the card just before it dies..

The adaptec i2o has a strange dialect to say the least.

> Am not using modules, compiled the i20 support directly into 2.4.14

Build the dpt_i2o scsi driver and use that, thats from Adaptec themselves
and speaks their i2o dialect
