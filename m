Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319293AbSIEXCq>; Thu, 5 Sep 2002 19:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319296AbSIEXCA>; Thu, 5 Sep 2002 19:02:00 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:8719 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S319293AbSIEXBv>; Thu, 5 Sep 2002 19:01:51 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200209052306.g85N6KR24300@devserv.devel.redhat.com>
Subject: Re: Linux 2.4.20-pre5-ac3
To: tadavis@lbl.gov (Thomas Davis)
Date: Thu, 5 Sep 2002 19:06:20 -0400 (EDT)
Cc: alan@redhat.com (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <3D77E1C2.560B6646@lbl.gov> from "Thomas Davis" at Sep 05, 2002 03:59:14 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Sep  5 12:11:21 localhost cardmgr[854]: executing: './ide start hde'
> > > Sep  5 12:11:21 localhost kernel: hde: bad special flag: 0x03

Ok I can duplicate this but on remove not on insert and it seems to 
depend on the card the Fujitsu rebadged 340Mb drive does seem to hang my
thinkpad on remove

Andre - did the PCMCIA drive and irq masking stuff ever get fully resolved ?
