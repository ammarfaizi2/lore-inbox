Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262449AbTIBUCr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 16:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261978AbTIBUCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 16:02:47 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:26893 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S261853AbTIBUCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 16:02:44 -0400
Date: Tue, 2 Sep 2003 17:02:30 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       linux-scsi@vger.kernel.org
Subject: Re: [2.4 patch] Fix IRQ_NONE clash in SCSI drivers
Message-ID: <20030902200230.GP3398@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Adrian Bunk <bunk@fs.tum.de>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
	linux-scsi@vger.kernel.org
References: <Pine.LNX.4.55L.0308271449170.23236@freak.distro.conectiva> <20030902184436.GO23729@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030902184436.GO23729@fs.tum.de>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 02, 2003 at 08:44:36PM +0200, Adrian Bunk escreveu:
> On Wed, Aug 27, 2003 at 02:52:45PM -0300, Marcelo Tosatti wrote:
> >...
> > Summary of changes from v2.4.22 to v2.4.23-pre1
> > ============================================
> >...
> > Arnaldo Carvalho de Melo:
> >   o irqreturn_t compatibility with 2.6
> >...
> 
> This change added an (empty) IRQ_NONE #define to interrupt.h.
> 
> Several scsi drivers are already using an IRQ_NONE.  Rename that to
> SCSI_IRQ_NONE (a similar change was done in 2.5 by Andrew Morton several
> months ago).
> 
> I've tested the compilation with 2.4.23-pre2.

Thanks a lot!

- Arnaldo
