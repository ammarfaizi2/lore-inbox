Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319387AbSIEXXQ>; Thu, 5 Sep 2002 19:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319388AbSIEXXQ>; Thu, 5 Sep 2002 19:23:16 -0400
Received: from postal2.lbl.gov ([131.243.248.26]:1731 "EHLO postal2.lbl.gov")
	by vger.kernel.org with ESMTP id <S319387AbSIEXXP>;
	Thu, 5 Sep 2002 19:23:15 -0400
Message-ID: <3D77E877.92BBA19F@lbl.gov>
Date: Thu, 05 Sep 2002 16:27:51 -0700
From: Thomas Davis <tadavis@lbl.gov>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-10smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre5-ac3
References: <200209052306.g85N6KR24300@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > > > Sep  5 12:11:21 localhost cardmgr[854]: executing: './ide start hde'
> > > > Sep  5 12:11:21 localhost kernel: hde: bad special flag: 0x03
> 
> Ok I can duplicate this but on remove not on insert and it seems to
> depend on the card the Fujitsu rebadged 340Mb drive does seem to hang my
> thinkpad on remove
> 

Ok, I just tried it - insert, wait about 5-10secs, locked.  the laptop
cooling fan comes on, which means the CPU is into infinite loop (or
something like it).

pulling the card - nada, no change.

thomas
