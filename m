Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292514AbSB0UFu>; Wed, 27 Feb 2002 15:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292922AbSB0UFQ>; Wed, 27 Feb 2002 15:05:16 -0500
Received: from mtao2.east.cox.net ([68.1.17.243]:7044 "EHLO lakemtao02.cox.net")
	by vger.kernel.org with ESMTP id <S292920AbSB0UCW>;
	Wed, 27 Feb 2002 15:02:22 -0500
Message-ID: <006301c1bfc9$a5c6de90$a7eb0544@CX535256D>
From: "Barubary" <barubary@cox.net>
To: <linux-kernel@vger.kernel.org>
Cc: "Rick Stevens" <rstevens@vitalstream.com>
In-Reply-To: <3C7D3587.8080609@vitalstream.com>
Subject: Re: Big file support
Date: Wed, 27 Feb 2002 12:02:12 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A lot of the kernel supports big files already.  The real problem is the
fact that the primary Linux file system, ext3, does not.  If you use some
file system besides ext3, big files should work.

Linux already has API calls to read big files.

-- Barubary

----- Original Message -----
From: "Rick Stevens" <rstevens@vitalstream.com>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Sent: Wednesday, February 27, 2002 11:37 AM
Subject: Big file support


> I'm not certain if this is the right place, but are there plans to
> have big file support (files >2GB) anytime soon?  I ask, as we use
> Linux to serve LOTS of streaming media and the logs for popular sites
> often exceed 2GB.  I'd like to see the ability to handle at least 16GB
> files, possibly more.
>
> Please cc: me on any replies if possible.  I've been REALLY busy and
> am finding it hard to keep up with l-k traffic.
>
> Thanks!
> ----------------------------------------------------------------------
> - Rick Stevens, SSE, VitalStream, Inc.      rstevens@vitalstream.com -
> - 949-743-2010 (Voice)                    http://www.vitalstream.com -
> -                                                                    -
> -              Never eat anything larger than your head              -
> ----------------------------------------------------------------------
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

