Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289190AbSAQQFk>; Thu, 17 Jan 2002 11:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289191AbSAQQFa>; Thu, 17 Jan 2002 11:05:30 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:3083 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289190AbSAQQFQ>; Thu, 17 Jan 2002 11:05:16 -0500
Subject: Re: clarification about redhat and vm
To: andrea@suse.de (Andrea Arcangeli)
Date: Thu, 17 Jan 2002 16:17:21 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org,
        riel@conectiva.com.br (Rik van Riel)
In-Reply-To: <20020117161055.K4847@athlon.random> from "Andrea Arcangeli" at Jan 17, 2002 04:10:55 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16RFE9-00042W-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> "If redhat doesn't use the -aa VM " was a short form of "if redhat
> cannot see the goodness of all the bugfixing work that happened between
> the 2.4.9 VM and any current branch 2.4, and so if they keep shipping
> 2.4.9 VM as the best one for DBMS and critical VM apps like the SAP
> benchmark".

The RH VM is totally unrelated to the crap in 2.4.9 vanilla. The SAP comment
begs a question. 2.4.10 seems to have problems remembering to actually 
do fsync()'s. How much of your SAP benchmark is from fsync's that dont
happen ? Do you get the same values with 2.4.18-aa ?

Alan
