Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265357AbUBER34 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 12:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266496AbUBER34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 12:29:56 -0500
Received: from virgo.i-cable.com ([203.83.111.75]:35724 "HELO
	virgo.i-cable.com") by vger.kernel.org with SMTP id S265357AbUBER3v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 12:29:51 -0500
Message-ID: <168301c3ec0e$24698be0$b8560a3d@kyle>
From: "Kyle" <kyle@southa.com>
To: "Bas Mevissen" <ml@basmevissen.nl>
Cc: <linux-kernel@vger.kernel.org>
References: <164601c3ec06$be8bd5a0$b8560a3d@kyle> <40227C20.80404@basmevissen.nl> <167301c3ec0d$4d8508c0$b8560a3d@kyle> <40227D9D.2070704@basmevissen.nl>
Subject: Re: ICH5 with 2.6.1 very slow
Date: Fri, 6 Feb 2004 01:33:17 +0800
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

hdparm /dev/hda
/dev/hda:
multcount = 16 (on)
IO_support = 1 (32-bit)
unmaskirq = 1 (on)
using_dma = 1 (on)
keepsettings = 0 (off)
readonly = 0 (off)
readahead = 256 (on)
geometry = 30401/255/63, sectors = 488397168, start = 0

tried with hdparm -a8192 /dev/hda, not much different
/dev/hdc same as /dev/hda

Kyle
----- Original Message ----- 
From: "Bas Mevissen" <ml@basmevissen.nl>
To: "Kyle" <kyle@southa.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Friday, February 06, 2004 1:30 AM
Subject: Re: ICH5 with 2.6.1 very slow


> Kyle wrote:
>
> > Yes they are PATA, I expect something like 40-50MB/s, now my much slower
> > Celeron 1.3T with 80GB/2M perform better than my ICH5!
> >
>
> What does 'hdparm /dev/hdX' say (X=a,b,c...)?
>
> Bas.
>
>
>

