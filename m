Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282242AbRLKU6I>; Tue, 11 Dec 2001 15:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282824AbRLKU56>; Tue, 11 Dec 2001 15:57:58 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:22714 "EHLO
	mailout05.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S282728AbRLKU5n>; Tue, 11 Dec 2001 15:57:43 -0500
Date: 11 Dec 2001 22:45:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8EfdooOHw-B@khms.westfalen.de>
In-Reply-To: <9v0mo1$ms$1@cesium.transmeta.com>
Subject: Re: On re-working the major/minor system
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <9v0mo1$ms$1@cesium.transmeta.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hpa@zytor.com (H. Peter Anvin)  wrote on 09.12.01 in <9v0mo1$ms$1@cesium.transmeta.com>:

> By author:    kaih@khms.westfalen.de (Kai Henningsen)

> > > The C library, and the POSIX standard, etc, etc.
> >
> > I think you'll find that there is *NOTHING* in either the C standard,
> > POSIX, or the Austin future-{POSIX,UNIX} standard that knows about major
> > or minor numbers.
> >
>
> It's not "future" anymore... Austin is now IEEE 1003.1-2001 and thus
> the new POSIX standard.

As of this Friday, yes.

> Anyway, look for things like tar, cpio, ISO 9660 and that class of
> standards.

Well, at least in Austin there is neither tar, cpio, nor 9660.

You are, however, right insofar as there's pax, which for ustar format has  
devmajor and devminor fields of 8 octets each, which contain unspecified  
information. (cpio format just has the rdev field.)


MfG Kai
