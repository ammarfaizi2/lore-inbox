Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262130AbTC1DOa>; Thu, 27 Mar 2003 22:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262178AbTC1DOa>; Thu, 27 Mar 2003 22:14:30 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:10246
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S262130AbTC1DO2>; Thu, 27 Mar 2003 22:14:28 -0500
Date: Thu, 27 Mar 2003 19:22:31 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Suparna Bhattacharya <suparna@in.ibm.com>, Jens Axboe <axboe@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] 2.5.66 bio traversal + IDE PIO patches on the way
In-Reply-To: <1048811262.3953.14.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10303271921130.25072-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yes it is revised and mapped into BIO proper.
This is one of the difficult things in 2.4 w/ BH but 2.5/2.6 BIO is
capable of satisfying the the state machine requirements proper.

Cheers,

On 28 Mar 2003, Alan Cox wrote:

> On Fri, 2003-03-28 at 00:10, Bartlomiej Zolnierkiewicz wrote:
> > > The IDE taskfile stuff for I/O is known broken. Thats why it
> > > is currently disabled. I plan to keep it that way until 2.7
> > 
> > What is broken?
> > It works just as good as standard code
> > (with taskfile fixes from ide-pio-1 and ide-pio-2 patches)
> > ...or I am missing something?
> 
> I hadn't realised you had rewritten all the PIO side of it when
> I wrote that. Looks like the revised plan is "pure taskfile for
> 2.6 care of Bartlomiej"
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

