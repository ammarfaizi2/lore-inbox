Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263097AbTCLIuo>; Wed, 12 Mar 2003 03:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263100AbTCLIuo>; Wed, 12 Mar 2003 03:50:44 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:14596
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S263097AbTCLIun>; Wed, 12 Mar 2003 03:50:43 -0500
Date: Wed, 12 Mar 2003 01:01:21 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Jens Axboe <axboe@suse.de>
cc: scott thomason <scott-kernel@thomasons.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bio too big device
In-Reply-To: <20030312085145.GJ811@suse.de>
Message-ID: <Pine.LNX.4.10.10303120100490.391-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


So lets dirty list the one drive by Paul G. and be done.
Can we do that?

Cheers,

On Wed, 12 Mar 2003, Jens Axboe wrote:

> On Tue, Mar 11 2003, Andre Hedrick wrote:
> > 
> > That has to be a BIO bug or IDE setup bug.
> 
> raid bug
> 
> > 256 sectors is legal and correct for 28-bit addressing.
> 
> yes, but ide itself limits incoming requests to 255 sectors. so it
> cannot get 256 sector requests.
> 
> -- 
> Jens Axboe
> 

Andre Hedrick
LAD Storage Consulting Group

