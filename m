Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292005AbSBYRFr>; Mon, 25 Feb 2002 12:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293296AbSBYRFh>; Mon, 25 Feb 2002 12:05:37 -0500
Received: from mailout5-1.nyroc.rr.com ([24.92.226.169]:3147 "EHLO
	mailout5.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S292005AbSBYRF3>; Mon, 25 Feb 2002 12:05:29 -0500
Message-ID: <05cb01c1be1e$c490ba00$1a01a8c0@allyourbase>
From: "Dan Maas" <dmaas@dcine.com>
To: "Rose, Billy" <wrose@loislaw.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <fa.n4lfl6v.h4chor@ifi.uio.no>
Subject: Re: ext3 and undeletion
Date: Mon, 25 Feb 2002 12:06:29 -0500
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

> but I don't want a Netware filesystem running on Linux, I
> want a *native* Linux filesystem (i.e. ext3) that has the
> ability to queue deleted files should I configure it to.

Rather than implementing this in the filesystem itself, I'd first try
writing a libc shim that overrides unlink(). You could copy files to safety,
or do anything else you want, before they actually get deleted...

Regards,
Dan

