Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275012AbRK0J4f>; Tue, 27 Nov 2001 04:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274875AbRK0J4b>; Tue, 27 Nov 2001 04:56:31 -0500
Received: from web20503.mail.yahoo.com ([216.136.226.138]:45354 "HELO
	web20503.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S275012AbRK0J4K>; Tue, 27 Nov 2001 04:56:10 -0500
Message-ID: <20011127095609.89426.qmail@web20503.mail.yahoo.com>
Date: Tue, 27 Nov 2001 10:56:09 +0100 (CET)
From: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
Subject: Re: Unresponiveness of 2.4.16
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Please try this lot:

Hi Andrew,

I just tried 2.4.16 with and without your patch.
During the
test, I wrote a 640 MB file on an IDE disk at an
average
speed of 10 MB/s. Without your patch, I could easily
reproduce the slugginess other people report, mostly
at
the login prompt. But when I applied your patch, I can
log in
immediately, so yes, I can say that your patch
improves
things dramatically.

I can't say yet if there are side effects, but I keep
testing.

Regards,
Willy


___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Courrier : http://courrier.yahoo.fr
