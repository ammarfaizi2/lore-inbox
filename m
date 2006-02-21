Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbWBUXhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbWBUXhU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 18:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWBUXhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 18:37:20 -0500
Received: from smtp.enter.net ([216.193.128.24]:33284 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1751218AbWBUXhT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 18:37:19 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Tue, 21 Feb 2006 18:37:36 -0500
User-Agent: KMail/1.8.1
Cc: matthias.andree@gmx.de, linux-kernel@vger.kernel.org
References: <43EB7BBA.nailIFG412CGY@burner> <200602201302.05347.dhazelton@enter.net> <43FAE10F.nailD121QL6LN@burner>
In-Reply-To: <43FAE10F.nailD121QL6LN@burner>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602211837.37211.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 February 2006 04:44, Joerg Schilling wrote:
> "D. Hazelton" <dhazelton@enter.net> wrote:
> > > I do use autoconf in the only senseful way.
> > >
<snip>
> > > The SCSI glue layer on Solaris is less than 50 kB. I did mention more
> > > than once that a uniquely layered system could save a lot of code by
> > > avoiding to implement things more than once.
> >
> > Does that glue code comprise the proposed SATL system? Recently I've come
> > across those whitepapers and opened a discussion about it on LKML.
>
> ??? Solaris supports SAS decives, is this your question?

SAS? No. To quote you quite frequently - RTFM. SATL is an entire system, 
similar to the old ide-scsi module, that sits on top of the SCSI and ATA 
interfaces and provides the capacity to access any disk device on the system 
using SCSI commands.

DRH
