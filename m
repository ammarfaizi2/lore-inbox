Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264681AbSLMOTa>; Fri, 13 Dec 2002 09:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264628AbSLMOTa>; Fri, 13 Dec 2002 09:19:30 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:8329 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S264681AbSLMOT3>; Fri, 13 Dec 2002 09:19:29 -0500
Date: Fri, 13 Dec 2002 15:23:40 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: andersen@codepoet.org, Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre1 IDE
Message-ID: <20021213142340.GB22190@louise.pinerecords.com>
References: <Pine.LNX.4.50L.0212101834240.23096-100000@freak.distro.conectiva> <20021212013546.GA30408@codepoet.org> <1039698648.21446.30.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039698648.21446.30.camel@irongate.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >     hda: DMA disabled
> >     ^^^^^^^^^^^^^^^^^
> > 
> > What's up with this?  For each drive in my system it claims it
> > has disabled DMA.  But hdparm later reports that DMA is in fact
> > enabled.  In fact, later on the kernel ever reports the drive
> > as being in UDMA 100 mode...  I think these "DMA disabled"
> > messages are bogus.
> 
> Cosmetic and known. It in fact turns DMA back on - quietly

Alan, I sent you a patch fixing this last week, can resend if necessary.

-- 
Tomas Szepe <szepe@pinerecords.com>
