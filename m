Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271144AbTHHKzs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 06:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271189AbTHHKzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 06:55:48 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:10631 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S271144AbTHHKzr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 06:55:47 -0400
Subject: Re: ide-tape broken (was Re: [PATCH] use ide-identify.h, fix
	endian bug)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Mikael Pettersson <mikpe@csd.uu.se>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SOL.4.30.0308080205490.24371-100000@mion.elka.pw.edu.pl>
References: <Pine.SOL.4.30.0308080205490.24371-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1060339916.4933.1.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 Aug 2003 11:51:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-08-08 at 01:10, Bartlomiej Zolnierkiewicz wrote:
> "new clean ATAPI tape drive" == the one yet to be written?
> 
> > coding style, kludges for Onstream, and an over-engineered
> > buffering scheme. And it's known to have problems with DMA.)
> 
> So you are familiar with the code, cool. ;-)
> 
> I will try to simplify ide-tape.c as much as possible.

A starting point might actually be cp ide-tape.c ide-tape-ontrack.c and
then zap the conditional mess in both. Thats roughly how scsi handles
it all with st and osst

