Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbTH0B0P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 21:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbTH0B0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 21:26:15 -0400
Received: from codepoet.org ([166.70.99.138]:44766 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S263015AbTH0B0O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 21:26:14 -0400
Date: Tue, 26 Aug 2003 19:26:16 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Promise IDE patches
Message-ID: <20030827012615.GA22578@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks Jan.
> 
> Marcelo can you apply these patches?
> 
> On Wednesday 27 of August 2003 00:31, Jan Niehusmann wrote:
> > Hi!
> >
> > Two weeks ago, I tried two patches against 2.4.21 regarding
> > LBA48
> > support. One limits the size of a drive to 137GB if LBA48 is
> > not
> > available. Without this patch, severe data corruption is
> > possible.
> >
> > http://gondor.com/linux/patch-limit48-2.4.21

My recent IDE patch also fixes this problem....

http://marc.theaimsgroup.com/?l=linux-kernel&m=106159060721871&w=2

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
