Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129805AbRBGRhG>; Wed, 7 Feb 2001 12:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129800AbRBGRgr>; Wed, 7 Feb 2001 12:36:47 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:19460 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129729AbRBGRga>; Wed, 7 Feb 2001 12:36:30 -0500
Date: Wed, 7 Feb 2001 11:31:47 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Gregory Maxwell <greg@linuxpower.cx>, linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: PCI-SCI Drivers v1.1-7 released
Message-ID: <20010207113147.A27215@vger.timpanogas.org>
In-Reply-To: <20010206182501.A23454@vger.timpanogas.org> <20010206190624.C23960@vger.timpanogas.org> <20010206210731.E1110@xi.linuxpower.cx> <20010207110852.A27089@vger.timpanogas.org> <20010207123213.V16592@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010207123213.V16592@devserv.devel.redhat.com>; from jakub@redhat.com on Wed, Feb 07, 2001 at 12:32:13PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2001 at 12:32:13PM -0500, Jakub Jelinek wrote:
> On Wed, Feb 07, 2001 at 11:08:52AM -0700, Jeff V. Merkey wrote:
> > Not supporting #ident for CVS managed code bases would see to 
> > me, at first glance, to be a show stopper to shipping a release 
> > of anything, since many folks need CVS support.
> 
> Could you please explain what you mean by not supporting #ident?
> It works just fine for me in all our gcc packages I've checked.
> 
> 	Jakub

It returns an "unknown keyword" error message from the sci source base. 
Offending source line is in /src/IRM/drv/src/prolog.h in version 
1.1-7.  

Jeff



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
