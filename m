Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319610AbSIMMHd>; Fri, 13 Sep 2002 08:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319613AbSIMMHc>; Fri, 13 Sep 2002 08:07:32 -0400
Received: from isis.telemach.net ([213.143.65.10]:17939 "HELO
	isis.telemach.net") by vger.kernel.org with SMTP id <S319610AbSIMMHb>;
	Fri, 13 Sep 2002 08:07:31 -0400
Message-ID: <002e01c25b1e$33a62c30$41448fd5@gregaslo2a75n3>
From: "Grega Fajdiga" <Gregor.Fajdiga@telemach.net>
To: "Anton Altaparmakov" <aia21@cantab.net>, <pkot@bezsensu.pl>
Cc: <linux-kernel@vger.kernel.org>
References: <5.1.0.14.2.20020913093230.00b1db50@pop.cus.cam.ac.uk>
Subject: Re: NTFS errors
Date: Fri, 13 Sep 2002 14:07:57 +0200
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

Good day,

Anton and Pawel thanks for the tip, all is well now.

Best Regards,
Grega
> At 08:35 13/09/02, Grega Fajdiga wrote:
> >Good day,
> >
> >I am using lk 2.4.19 + a NTFS 2.1.0 patch. Once in a while I get
> >lots of these errors:
> >
> >Sep 10 09:24:27 mujo kernel: NTFS-fs error (device 03:01):
> >ntfs_ucstonls(): Unicode name contains characters that cannot be
converted
> >to character set iso8859-1.
> >Sep 12 09:39:29 mujo kernel: NTFS-fs error (device 03:01):
> >ntfs_ucstonls(): Unicode name contains characters that cannot be
converted
> >to character set iso8859-1.
> >Sep 13 09:19:28 mujo kernel: NTFS-fs error (device 03:01):
> >ntfs_ucstonls(): Unicode name contains characters that cannot be
converted
> >to character set iso8859-1.
> >Sep 13 09:20:22 mujo kernel: NTFS-fs error (device 03:01):
> >ntfs_ucstonls(): Unicode name contains characters that cannot be
converted
> >to character set iso8859-1.
> >
> >
> >Are these errors serious? How can I get rid of them?
>
> The errors mean that there are one or more file names containing
characters
> that cannot be displayed with the ISO8859-1 character set. This means that
> you cannot see that those files exist and you cannot access them.
>
> To get rid of the messages and to display the affected file names, you
need
> to use the appropriate character set (which depends on what characters are
> in the file names).
>
> The only character set that can work with all characters is UTF8, so I
> would highly recommend to always use UTF8 and you will never see these
errors.
>
> Best regards,
>
>          Anton
>
>
> --
>    "I haven't lost my mind... it's backed up on tape." - Peter da Silva
> --
> Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
> Linux NTFS Maintainer / IRC: #ntfs on irc.freenode.net
> WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
>
>

