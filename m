Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314938AbSG3HU0>; Tue, 30 Jul 2002 03:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315120AbSG3HU0>; Tue, 30 Jul 2002 03:20:26 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:13071
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S314938AbSG3HU0>; Tue, 30 Jul 2002 03:20:26 -0400
Date: Tue, 30 Jul 2002 00:17:31 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Jens Axboe <axboe@suse.de>
cc: Eric Altendorf <EricAltendorf@orst.edu>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: What patch to get stable IDE in 2.5?
In-Reply-To: <20020730083323.F4445@suse.de>
Message-ID: <Pine.LNX.4.10.10207300006430.17634-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry about that Jens, I should have qualified it with the taskfile io
operations and the other subdrivers added and other tweaks.  I can not
comment on the legacy path as it relates to 2.5, and that was my mistake.

Corrected post:

The original TASKFILE IO transport layer for which 2.5 was to be based
upon is correct and fixed wrt to 2.5 BIO API.  Additional updates include
ide-floppy and ide-tape and a few updates to ide-scsi24.

If it were not for you bring the port forward I would not have considered
it viable.  For that I thank you for your efforts, and again I apologize
for wrongful comments do to my lack of clarity.

Also the group refers to NCITS membership, for which "The 'Hale Landis'",
is its alternate and we work togather as it relates to the paper spec.
http://www.ata-atapi.com/.  Other than that public point of record, I am
the public rep of LAD-SCG.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Tue, 30 Jul 2002, Jens Axboe wrote:

> On Mon, Jul 29 2002, Andre Hedrick wrote:
> > 
> > There are no problems if you get the patch for LAD and not K dot O.
> 
> Sorry, but this sort of statement can't help but piss me off. I do all
> the work forward porting 2.4 IDE to 2.5, then you slap a LAD label on it
> (why?! To sprinkle it with "LAD Storage Consulting Group" [1] pee?) and
> claim the foundation on which you stand is _broken_?
> 
> Feel free to point out where I'm wrong.
> 
> [1] 'group' meant more than 1, last I checked.
> 
> -- 
> Jens Axboe
> 

