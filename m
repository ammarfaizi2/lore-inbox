Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132151AbRDEKoE>; Thu, 5 Apr 2001 06:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132601AbRDEKny>; Thu, 5 Apr 2001 06:43:54 -0400
Received: from [62.90.5.51] ([62.90.5.51]:1289 "EHLO salvador.shunra.co.il")
	by vger.kernel.org with ESMTP id <S132151AbRDEKnn>;
	Thu, 5 Apr 2001 06:43:43 -0400
Message-ID: <F1629832DE36D411858F00C04F24847A216801@SALVADOR>
From: Gabi Davar <gabi@SHUNRA.co.il>
To: "'Remko van der Vossen'" <remko.van.der.vossen@cmg.nl>
Cc: "Linux Kernel Mailing List (E-mail)" <linux-kernel@vger.kernel.org>
Subject: RE: Calling kernel level function from user level program
Date: Thu, 5 Apr 2001 12:48:12 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can't just call it, you need to either create a system call, or use
IOCTLs.

Read the FAQ at http://www.tux.org/lkml/ for general info and sources of
information.

-gabi

> -----Original Message-----
> From: Remko van der Vossen [mailto:remko.van.der.vossen@cmg.nl]
> Sent: Thursday, April 05, 2001 11:59 AM
> To: 'linux-kernel@vger.kernel.org'
> Subject: Calling kernel level function from user level program
> 
> 
> Hi Guys,
> 
> I'd like to know how I call a kernel level function which i 
> made myself (in
> a module) from a user level program, i tried a header file 
> with extern but
> that didn't work.
> 
> Bye,
> 
> Remko van der Vossen
> CMG Eindhoven
> Remko.van.der.Vossen@cmg.nl
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
