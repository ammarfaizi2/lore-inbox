Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273154AbRIPCiH>; Sat, 15 Sep 2001 22:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273147AbRIPCh6>; Sat, 15 Sep 2001 22:37:58 -0400
Received: from c1890829-a.stcla1.sfba.home.com ([24.5.220.226]:54281 "HELO
	luban.org") by vger.kernel.org with SMTP id <S273166AbRIPChp>;
	Sat, 15 Sep 2001 22:37:45 -0400
Message-ID: <3BA40FEC.A6E0557E@luban.org>
Date: Sat, 15 Sep 2001 19:35:24 -0700
From: Vitaly Luban <vitaly@luban.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dan Kegel <dank@kegel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] Signal-per-fd for RT signals
In-Reply-To: <3BA2AFFF.C7B8C4DF@kegel.com> <3BA2E144.FB0E5D55@luban.org> <3BA2E99A.1134E382@kegel.com> <3BA350A7.7D39FC23@kegel.com> <3BA3C61A.DED5A27A@luban.org> <3BA3D10B.FE3C6C79@kegel.com>
Content-Type: multipart/mixed;
 boundary="------------1510C6A12CA5CFE8CDFD1614"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------1510C6A12CA5CFE8CDFD1614
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit

Dan Kegel wrote:

> But I doubt very much that SIGIO style readiness notification will ever
> be used with files.  aio_{read,write} style completion notification is
> much more appropriate for file I/O, and my proposal (if I make it) will not
> affect that.

Well, when I have an app, that deals primarily with network I/O, and, at the same time
has some file I/O, it's only logical to have all I/O handling within the same event
loop, and if loop is RT-signals based...

> Thanks again for creating and maintaining your patch!  I look forward to
> stress-testing the next version.

Could you please try attached one? It's mostly untested, but my home site
will be down next week.

And thank you for your efforts also :)
I'm looking forward to see a test case, all I could come up with happily
runs on the old version.

Thanks again,
    Vitaly.


--------------1510C6A12CA5CFE8CDFD1614
Content-Type: application/x-gzip;
 name="one-sig-perfd-2.4.9.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="one-sig-perfd-2.4.9.patch.gz"

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
Q9myX5xHDHRaJ0P/AzwH2bsJHAAA
--------------1510C6A12CA5CFE8CDFD1614--

