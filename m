Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263194AbTCLOne>; Wed, 12 Mar 2003 09:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263195AbTCLOne>; Wed, 12 Mar 2003 09:43:34 -0500
Received: from dsl2-09018-wi.customer.centurytel.net ([209.206.215.38]:65418
	"HELO thomasons.org") by vger.kernel.org with SMTP
	id <S263194AbTCLOnd>; Wed, 12 Mar 2003 09:43:33 -0500
From: scott thomason <scott-kernel@thomasons.org>
Reply-To: scott-kernel@thomasons.org
To: Andre Hedrick <andre@linux-ide.org>, axboe@suse.de,
       Andries Brouwer <aebr@win.tue.nl>
Subject: Re: bio too big device
Date: Wed, 12 Mar 2003 08:54:17 -0600
User-Agent: KMail/1.5
References: <Pine.LNX.4.10.10303120205250.391-100000@master.linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.10303120205250.391-100000@master.linux-ide.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303120854.17410.scott-kernel@thomasons.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just so everyone knows...these aren't ancient drives I'm talking 
about. One is a 30GB Maxtor 5T030H3, less than two years old 
IIRC, and the other is a 30GB IBM-DTLA-307030 purchased about 
six months ago.
---scott

On Wednesday 12 March 2003 04:07 am, Andre Hedrick wrote:
> No that is wrong to force all other drives to under perform
> because on one.  If you are going to impose 255 then pushi it
> back to 128 were it is a single scatter list.  This issue has
> bugged me for years and now that we know the exact model we
> apply an exception rule to it.
>
> This is one silly bug that I have heard about.
>
> Cheers,
>
> On Wed, 12 Mar 2003, Jens Axboe wrote:
> > On Wed, Mar 12 2003, Andre Hedrick wrote:
> > > So lets dirty list the one drive by Paul G. and be done.
> > > Can we do that?
> >
> > Who cares, really? There's not much point in doing it, we're
> > talking 248 vs 256 sectors in reality. I think it's a _bad_
> > idea, lets just keep it at 255 and avoid silly drive bugs
> > there.
> >
> > --
> > Jens Axboe
>
> Andre Hedrick
> LAD Storage Consulting Group

