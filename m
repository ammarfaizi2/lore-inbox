Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130435AbRCCJeY>; Sat, 3 Mar 2001 04:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130437AbRCCJeE>; Sat, 3 Mar 2001 04:34:04 -0500
Received: from mailout2-1.nyroc.rr.com ([24.92.226.165]:22751 "EHLO
	mailout2-0.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S130435AbRCCJd5>; Sat, 3 Mar 2001 04:33:57 -0500
Message-ID: <005401c0a3c5$d0b71c80$0701a8c0@morph>
From: "Dan Maas" <dmaas@dcine.com>
To: "Nathalie Barat" <nbarat@cirpack.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <fa.l0ns1gv.i6sloa@ifi.uio.no>
Subject: Re: Using IPCSysV in a device driver
Date: Sat, 3 Mar 2001 04:39:16 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am wondering if it is permitted to use message queues between a user
> application and a device driver module...
> Can anyone help me?

It may be theoretically possible, but an easier and much more common
approach to this type of thing is for the driver to export an mmap()
interface. You could synchronize using poll() I think...

Regards,
Dan

