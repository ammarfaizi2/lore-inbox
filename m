Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268075AbUHFPHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268075AbUHFPHh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 11:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268082AbUHFPHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 11:07:37 -0400
Received: from S010600c0f014b14a.ss.shawcable.net ([24.78.210.69]:782 "HELO
	discworld.dyndns.org") by vger.kernel.org with SMTP id S268075AbUHFPHZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 11:07:25 -0400
Date: Fri, 6 Aug 2004 09:14:55 -0600
From: Charles Cazabon <linux@discworld.dyndns.org>
To: Jens Axboe <axboe@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Zinx Verituse <zinx@epicsol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-cd problems
Message-ID: <20040806151455.GE29393@discworld.dyndns.org>
Mail-Followup-To: Jens Axboe <axboe@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Zinx Verituse <zinx@epicsol.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040731153609.GG23697@suse.de> <20040731182741.GA21845@bliss> <20040731200036.GM23697@suse.de> <20040731210257.GA22560@bliss> <20040805054056.GC10376@suse.de> <1091739966.8418.38.camel@localhost.localdomain> <20040806054424.GB10274@suse.de> <20040806062331.GE10274@suse.de> <1091794470.16306.11.camel@localhost.localdomain> <20040806143258.GB23263@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040806143258.GB23263@suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
> On Fri, Aug 06 2004, Alan Cox wrote:
> > 		default:
> > 			if(capable(CAP_SYS_RAWIO))
> > 			/* Only administrators get to do arbitary things */
> 
> That's the case I don't agree with, and why I didn't like the idea
> originally. That suddenly requires a patching of the kernel because of
> new commands in new devices. Like when dvd readers became common, you
> can't just require people to update their kernel because a few new
> commands are needed to drive them from user space.

The problem is that what if one of the new commands is IGNITE_PLATTER?
Unknown commands can do anything, are therefore extremely dangerous, and
should be restricted.

Charles
-- 
-----------------------------------------------------------------------
Charles Cazabon                            <linux@discworld.dyndns.org>
GPL'ed software available at:     http://www.qcc.ca/~charlesc/software/
-----------------------------------------------------------------------
