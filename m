Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281459AbRKTW7U>; Tue, 20 Nov 2001 17:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281461AbRKTW7M>; Tue, 20 Nov 2001 17:59:12 -0500
Received: from mailout6-1.nyroc.rr.com ([24.92.226.177]:50157 "EHLO
	mailout6.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S281459AbRKTW64>; Tue, 20 Nov 2001 17:58:56 -0500
Message-ID: <040701c17215$357711c0$1a01a8c0@allyourbase>
From: "Dan Maas" <dmaas@dcine.com>
To: <root@chaos.analogic.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <fa.kb6ct7v.pgku0d@ifi.uio.no> <fa.k8qdvcv.184ak2l@ifi.uio.no>
Subject: Re: Swap
Date: Tue, 20 Nov 2001 17:46:35 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is 'nice' for the server, it doesn't have the overhead of maintaining
> a file-system state. That's why servers are supposed to be read-only.
> However, somebody has got to write the stuff to the file-system that's
> going to (eventually) be read-only. Beware when such access occurs.

But NFS still allows atomic rename() right? Isn't it considered essential to
write the new executable or library under a different name, and then
atomically rename() over the old one? If you write() directly into the
executable, you will get what you deserve...

Regards,
Dan

