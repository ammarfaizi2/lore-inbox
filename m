Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267799AbTBUXIT>; Fri, 21 Feb 2003 18:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267800AbTBUXIT>; Fri, 21 Feb 2003 18:08:19 -0500
Received: from CPE-203-51-31-54.nsw.bigpond.net.au ([203.51.31.54]:27387 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S267799AbTBUXIS>; Fri, 21 Feb 2003 18:08:18 -0500
Message-ID: <3E56B3BC.1FB61E17@eyal.emu.id.au>
Date: Sat, 22 Feb 2003 10:18:20 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.21-pre4-aa3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21pre4-ac5 - bad aic7xxx
References: <200302211437.h1LEbXa25951@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> Linux 2.4.21pre4-ac5

CONFIG_SCSI_AIC7XXX=m does not build. Some undefined manifest constants
and
types. I suspect an out-of-date header. I disabled it for now.

 -ac4 built just fine, BTW Makefile version was not bumped in -ac5...

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
