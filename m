Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbTHTAL7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 20:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbTHTAL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 20:11:59 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:7323
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S261642AbTHTALV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 20:11:21 -0400
Date: Tue, 19 Aug 2003 20:21:08 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: "Bryan D. Stine" <admin@kentonet.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DVD ROM on 2.6
Message-ID: <20030819202108.A25325@animx.eu.org>
References: <20030819193456.B25148@animx.eu.org> <200308192003.22182.admin@kentonet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <200308192003.22182.admin@kentonet.net>; from Bryan D. Stine on Tue, Aug 19, 2003 at 08:03:18PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Try passing the -t iso9660 option to mount or (if that doesn't work) you could 
> go so far as to removing the UDF support from the kernel.

I had a brain fart.  I was using -o instead of -t =(

I do have DVDs playing now on 2.6.0-test3.  I used ide-cd instead of
ide-scsi.  apparently the scsi layer didn't like it.
Buffer I/O error on device sr1, logical block 7651
Buffer I/O error on device sr1, logical block 7652
Buffer I/O error on device sr1, logical block 7653
end_request: I/O error, dev sr1, sector 660400

I would get tons of Buffer I/O errors and some end_requests like the above

> > I'm trying out 2.6 on one of my test boxes with an IDE dvd drive.  I'm
> > using ide-scsi (I prefer scdx as opposed to hdx).  I noticed that any
> > attempt to mount a DVD movie (lord of the rings comes to mind) it mounts as
> > UDF.  My laptop mounts this same dvd as iso9660.
> >
> > I've also been unable to play DVDs on this machine, but I don't have the
> > same packages installed as I do on my laptop.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
