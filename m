Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316522AbSEOXSi>; Wed, 15 May 2002 19:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316521AbSEOXSh>; Wed, 15 May 2002 19:18:37 -0400
Received: from ncc1701.cistron.net ([195.64.68.38]:12042 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S316520AbSEOXSh>; Wed, 15 May 2002 19:18:37 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: IO stats in /proc/partitions
Date: Wed, 15 May 2002 23:18:34 +0000 (UTC)
Organization: Cistron
Message-ID: <abuqca$ipn$2@ncc1701.cistron.net>
In-Reply-To: <UTC200205041959.g44JxQa20044.aeb@smtp.cwi.nl> <Pine.LNX.4.21.0205151838001.21222-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=iso-8859-15
X-Trace: ncc1701.cistron.net 1021504714 19255 195.64.65.67 (15 May 2002 23:18:34 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.21.0205151838001.21222-100000@freak.distro.conectiva>,
Marcelo Tosatti  <marcelo@conectiva.com.br> wrote:
>On Sat, 4 May 2002 Andries.Brouwer@cwi.nl wrote:
>
>> However, I see that these days the pollution of /proc/partitions
>> is becoming official - it is part of patch-2.4.19-pre7.
>> I strongly object, and hope it is not too late to revert this.
>> 
>The change can possibly break userlevel tools which were working with
>2.4.18.

Perhaps, but I had the opposite experience. I noticed by accident
that iostat (as included in Debian) suddenly had working extended
statistics. So there are *certainly* tools that get fixed by
2.4.19-pre7. I was pleasantly surprised.

>Christoph, please create a /proc/diskstatistics file or something like
>that and send me a patch.

Bummer, I'm using Debian, and iostat is in woody (frozen, about to
be released) - that means Debian users will have to wait to the
next release, another two years perhaps, before iostat gets working.

Why not keep it as it is, it's probably not going to break
anything as debian and redhat tools already know about this
apparently. 2.5 is about new features, 2.4 is about stability
and, though some might oppose, folding in stable patches that
have been in vendor kernels for months or years.

Mike.
-- 
"Insanity -- a perfectly rational adjustment to an insane world."
  - R.D. Lang

