Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129444AbRAYBLR>; Wed, 24 Jan 2001 20:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129441AbRAYBLI>; Wed, 24 Jan 2001 20:11:08 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:45842 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135296AbRAYBKx>; Wed, 24 Jan 2001 20:10:53 -0500
Subject: Re: Is sendfile all that sexy?
To: sape@iq.rulez.org (Sasi Peter)
Date: Thu, 25 Jan 2001 01:11:07 +0000 (GMT)
Cc: jas88@cam.ac.uk (James Sutherland), linux-kernel@vger.kernel.org
In-Reply-To: <200101241512.QAA01140@iq.rulez.org> from "Sasi Peter" at Jan 24, 2001 04:12:49 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14LawQ-000893-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think, that is not what we need. Once Ingo wrote, that since HTTP 
> serving can also be viewed as a kind of fileserving, it should be 
> possible to create a TUX like module for the same framwork, that serves 
> using the SMB protocol instead of HTTP...


Kernel SMB is basically not a sane idea. sendfile can help it though

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
