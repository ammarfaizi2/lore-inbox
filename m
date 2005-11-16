Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030319AbVKPODx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030319AbVKPODx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 09:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030339AbVKPODx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 09:03:53 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:39815 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S1030319AbVKPODw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 09:03:52 -0500
Date: Wed, 16 Nov 2005 15:03:51 +0100
From: Sander <sander@humilis.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: sander@humilis.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-mm1 libata pata_via
Message-ID: <20051116140351.GA14284@favonius>
Reply-To: sander@humilis.net
References: <6397E994-0BC3-445F-BF2B-CD3D0ADB0E02@bootc.net> <20051108121318.GB23549@favonius> <1131455213.25192.26.camel@localhost.localdomain> <1131467696.25192.47.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131467696.25192.47.camel@localhost.localdomain>
X-Uptime: 15:00:09 up 2 days,  3:31, 22 users,  load average: 1.19, 1.55, 1.64
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote (ao):
> On Maw, 2005-11-08 at 13:06 +0000, Alan Cox wrote:
> > On Maw, 2005-11-08 at 13:13 +0100, Sander wrote:
> > > The two pata disks are master and slave. I might try them on separate
> > > channels later (especially if you want me to :-)
> > 
> > Would be interesting. It shouldn't change the behaviour but more info is
> > good.
> 
> Also can you tell me if the drives are on 40 or 80 wire cables ?

The drives are on a 40 wire cable. I'll change that to 80 right now.

Btw, with unpatched kernel 2.6.14-mm2 I don't see the drives anymore.

# zgrep CONFIG_SCSI_PATA_VIA /proc/config.gz 
CONFIG_SCSI_PATA_VIA=y

-- 
Humilis IT Services and Solutions
http://www.humilis.net
