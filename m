Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263027AbTCSNJD>; Wed, 19 Mar 2003 08:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263028AbTCSNJD>; Wed, 19 Mar 2003 08:09:03 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:31875
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263027AbTCSNJC>; Wed, 19 Mar 2003 08:09:02 -0500
Subject: Re: ide-scsi failure on 2.5.65
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: dan carpenter <d_carpenter@sbcglobal.net>
Cc: Eric Benson <eric_a_benson@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200303190704.h2J74gWE193004@pimout4-ext.prodigy.net>
References: <20030318231033.31663.qmail@web10105.mail.yahoo.com>
	 <200303190704.h2J74gWE193004@pimout4-ext.prodigy.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048084238.30751.29.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 19 Mar 2003 14:30:39 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-18 at 13:44, dan carpenter wrote:
> On Wednesday 19 March 2003 12:10 am, Eric Benson wrote:
> > I installed Red Hat 8.0 on an IBM NetVista 2283-55U,
> > an all-in-one desktop 1.8ghz P4. I downloaded and
> > compiled the 2.5.65 kernel with ide-scsi emulation and
> > kernel debugging enabled.
> >
> ...
> > 14:18:33 hdb: drive not ready for command
> > 14:18:33 ide-scsi: reset called for 0
> > 14:18:33 bad: scheduling while atomic!
> 
> This problem is known.  Try the driver from the -ac kernel.

You need 2.4.21pre-ac for that, the 2.5 code is wildly different
and I've not tackled it yet. Its about six weeks down the todo list
at the moment

