Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263435AbTEMU3k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 16:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263445AbTEMU3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 16:29:40 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:51205
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S263435AbTEMU3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 16:29:31 -0400
Date: Tue, 13 May 2003 13:34:44 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: "Mudama, Eric" <eric_mudama@maxtor.com>
cc: Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       Dave Jones <davej@codemonkey.org.uk>, Oleg Drokin <green@namesys.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Oliver Neukum <oliver@neukum.org>,
       lkhelp@rekl.yi.org, linux-kernel@vger.kernel.org
Subject: RE: 2.5.69, IDE TCQ can't be enabled
In-Reply-To: <785F348679A4D5119A0C009027DE33C102E0D346@mcoexc04.mlm.maxtor.com>
Message-ID: <Pine.LNX.4.10.10305131329390.2718-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Correct no drives shipped.

Maxtor failed to move forward in updating the device side TCQ.
I will have to look up my email record to give you who I was working with
and talking to about the issues.  I do know it was in the Longmont
division.

The last discussion I had with Maxtor releated in forcing the state
machine to default to bus release on execution of the command block.
This would fix the the gaping hole in the protocol.  The effects from this
single change were not fully white board material, and may have addressed
or covered the other two pitfalls.

Drop the ball, meaning it was started and then tabled.
Tabled because of SATA/SAS.

Comments?


Andre Hedrick
LAD Storage Consulting Group


On Tue, 13 May 2003, Mudama, Eric wrote:

> 
> 
> -----Original Message-----
> >From: Andre Hedrick [mailto:andre@linux-ide.org]
> >Sent: Tuesday, May 13, 2003 2:04 PM
> >To: Jens Axboe
> >Cc: Jeff Garzik; Dave Jones; Mudama, Eric; Oleg Drokin; Bartlomiej
> >Zolnierkiewicz; Alan Cox; Oliver Neukum; lkhelp@rekl.yi.org;
> >linux-kernel@vger.kernel.org
> >Subject: Re: 2.5.69, IDE TCQ can't be enabled
> >
> >Why are we still dorking around with device TCQ.
> >There are three holes in the state machine.
> >IBM's design (goat-screw) is lamer than a duck.
> >Maxtor thought about redoing TCQ, to not leave the host in a daze but
> >dropped the ball.
> 
> What ball, exactly, did we drop?  We have yet to ship a TCQ drive because we
> think we can get it "right" but it is taking us time, in our view, to do
> properly.
> 
> --eric
> 

