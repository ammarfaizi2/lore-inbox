Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265937AbUBKQsN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 11:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265939AbUBKQsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 11:48:13 -0500
Received: from libra.i-cable.com ([203.83.111.73]:61325 "HELO
	libra.i-cable.com") by vger.kernel.org with SMTP id S265937AbUBKQr7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 11:47:59 -0500
Message-ID: <004501c3f0ae$ecdd2ec0$b8560a3d@kyle>
From: "Kyle" <kyle@southa.com>
To: "Bas Mevissen" <ml@basmevissen.nl>
Cc: <linux-kernel@vger.kernel.org>
References: <164601c3ec06$be8bd5a0$b8560a3d@kyle> <40227C20.80404@basmevissen.nl> <167301c3ec0d$4d8508c0$b8560a3d@kyle> <40227D9D.2070704@basmevissen.nl> <168301c3ec0e$24698be0$b8560a3d@kyle> <4023682E.3060809@basmevissen.nl> <001101c3ecf8$b0f50cc0$b8560a3d@kyle> <40274581.4030002@basmevissen.nl>
Subject: Re: ICH5 with 2.6.1 very slow
Date: Wed, 11 Feb 2004 22:54:08 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Today I tried with compile the kernel 2.6.1 with:

IGNORE word93 Validation BITS (IDEDMA_IVB) = y

The result looks a bit better, got 30MB/s at /dev/hda and 37MB/s at /dev/hdc
(38MB/s and 55MB/s at kernel 2.4.20)

Still very strange, /dev/hda and /dev/hda are exactly same model harddisk.

Also, the result still can't compare with my another much slower machine
Celeron / ICH4 / 2 x WD 120GB (md1), which got 46MB/s at both /dev/hda and
/dev/hdc,

Kyle

----- Original Message ----- 
From: "Bas Mevissen" <ml@basmevissen.nl>
To: "Kyle" <kyle@southa.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Monday, February 09, 2004 4:32 PM
Subject: Re: ICH5 with 2.6.1 very slow


> Kyle wrote:
>
> > Today I tried
>
> (...)
>
> This is quite strange. The only thing I can think of is that the
> hardware (?) raid1 is causing problems with 2.6.
>
> Is there a possibility for you to test without it?
>
> Currently, I don't have a decent PATA disk luyng around, so I cannot
> verify anything for you.
>
> Regards,
>
> Bas.
>
>
>

