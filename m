Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266451AbUBLOFU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 09:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266452AbUBLOFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 09:05:20 -0500
Received: from aries.i-cable.com ([203.83.111.74]:19429 "HELO
	aries.i-cable.com") by vger.kernel.org with SMTP id S266451AbUBLOFO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 09:05:14 -0500
Message-ID: <02e701c3f171$c06a5b60$353ffea9@kyle>
From: "Kyle" <kyle@southa.com>
To: "Jamie Lokier" <jamie@shareable.org>
Cc: <linux-kernel@vger.kernel.org>
References: <164601c3ec06$be8bd5a0$b8560a3d@kyle> <40227C20.80404@basmevissen.nl> <167301c3ec0d$4d8508c0$b8560a3d@kyle> <40227D9D.2070704@basmevissen.nl> <168301c3ec0e$24698be0$b8560a3d@kyle> <4023682E.3060809@basmevissen.nl> <001101c3ecf8$b0f50cc0$b8560a3d@kyle> <40274581.4030002@basmevissen.nl> <004501c3f0ae$ecdd2ec0$b8560a3d@kyle> <20040212084110.GB20898@mail.shareable.org>
Subject: Re: ICH5 with 2.6.1 very slow
Date: Thu, 12 Feb 2004 22:08:55 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes I read the thread and re-compile with IDEDMA_IVB= y, got some
performance back, but is still far slower than 2.4

----- Original Message ----- 
From: "Jamie Lokier" <jamie@shareable.org>
To: "Kyle" <kyle@southa.com>
Cc: "Bas Mevissen" <ml@basmevissen.nl>; <linux-kernel@vger.kernel.org>
Sent: Thursday, February 12, 2004 4:41 PM
Subject: Re: ICH5 with 2.6.1 very slow


> Kyle wrote:
> > Today I tried with compile the kernel 2.6.1 with:
> >
> > IGNORE word93 Validation BITS (IDEDMA_IVB) = y
> >
> > The result looks a bit better, got 30MB/s at /dev/hda and 37MB/s at
/dev/hdc
> > (38MB/s and 55MB/s at kernel 2.4.20)
>
> Aha...
>
> Have a look at the thread called "[RFC] IDE 80-core cable detect -
> chipset-specific code to over-ride eighty_ninty_three()".
>
> It specifically deals with ICH5 and is probably the same problem as
> you're seeing.
>
> -- Jamie
>

