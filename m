Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318873AbSHWPSd>; Fri, 23 Aug 2002 11:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318882AbSHWPSc>; Fri, 23 Aug 2002 11:18:32 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:22520 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318873AbSHWPSb>; Fri, 23 Aug 2002 11:18:31 -0400
Subject: Re: 2.4.19 - Promise TX2 Ultra133 (pdc20269) sticks at UDMA33
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: barrie_spence@agilent.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020823144016.GM14278@louise.pinerecords.com>
References: <C12D24916888D311BC790090275414BB0B724742@oberon.britain.agilent.com> 
	<20020823144016.GM14278@louise.pinerecords.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 23 Aug 2002 16:24:09 +0100
Message-Id: <1030116249.5911.19.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-23 at 15:40, Tomas Szepe wrote:
> > Trying hdparm -X69 after boot gives the message "Speed warnings UDMA 3/4/5 is not functional."
> 
> Known issue.
> Boot/load the ide core mod with ideX=ata66, repeat for all your promise hosts.
Providing you have 80pin cables

