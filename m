Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317390AbSGIUE6>; Tue, 9 Jul 2002 16:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317391AbSGIUE5>; Tue, 9 Jul 2002 16:04:57 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47877 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317390AbSGIUE5>; Tue, 9 Jul 2002 16:04:57 -0400
Subject: Re: ATAPI + cdwriter problem
To: as@sci.fi (Anssi Saari)
Date: Tue, 9 Jul 2002 21:29:31 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020709195437.GA1834@sci.fi> from "Anssi Saari" at Jul 09, 2002 10:54:37 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17S1c3-0005eu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  
> I had a similar experience when trying my CD writer on pdc20265 and a
> cmd649 based board. Sometimes a write goes fine, sometimes that error
> comes up and you get a coaster. Writer is an LG GCE-8160B.  It works
> fine on the VIA 686b however, except for certain speed related issues
> (audio writes at > 8x make system unresponsive, data writes ok, more
> in http://marc.theaimsgroup.com/?l=linux-kernel&m=101826880719379&w=2).

If you are having PDC202xx problems do try the patch Hank posted recently.
It disables the raid controllers which is something we need to discuss in
more detail to do in a better way but the rest of it is what Promise believe
fixes the other problems - and it would benefit from much testing
