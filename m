Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266299AbRGFIkz>; Fri, 6 Jul 2001 04:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266300AbRGFIkf>; Fri, 6 Jul 2001 04:40:35 -0400
Received: from d06lmsgate.uk.ibm.com ([195.212.29.1]:3744 "EHLO
	d06lmsgate.uk.ibm.COM") by vger.kernel.org with ESMTP
	id <S266299AbRGFIkZ>; Fri, 6 Jul 2001 04:40:25 -0400
Importance: Normal
Subject: Re: Kernel Module tracing.
To: Constantin Loizides <Constantin.Loizides@isg.de>
Cc: Tom spaziani <digiphaze@deming-os.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFB413B86C.A9FE8492-ON80256A81.002C7A0A@portsmouth.uk.ibm.com>
From: "Richard J Moore" <richardj_moore@uk.ibm.com>
Date: Fri, 6 Jul 2001 09:08:19 +0100
X-MIMETrack: Serialize by Router on D06ML023/06/M/IBM(Release 5.0.6 |December 14, 2000) at
 06/07/2001 09:38:53
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I missed your original post. If you want some form or generic tracing in
the kernel then DProbes with LTT might help.

With these tools you can build tracepoints without modifying the source.
You could use system.map to generate simple tracepoint definitions (having
written yourself a small program to parse the map output).

Richard

Richard Moore -  RAS Project Lead - Linux Technology Centre (ATS-PIC).
http://oss.software.ibm.com/developerworks/opensource/linux
Office: (+44) (0)1962-817072, Mobile: (+44) (0)7768-298183
IBM UK Ltd,  MP135 Galileo Centre, Hursley Park, Winchester, SO21 2JN, UK


Constantin Loizides <Constantin.Loizides@isg.de> on 05/07/2001 16:38:26

Please respond to Constantin Loizides <Constantin.Loizides@isg.de>

To:   Tom spaziani <digiphaze@deming-os.org>
cc:   linux-kernel <linux-kernel@vger.kernel.org>
Subject:  Re: Kernel Module tracing.


> I want this.  I've been thinking about it since your original post, and
I also would be very much interested in having such a great
tool by hand.
Please mail me any information, or code to try, thanx!

>
> Perhaps you should also think about a non-devfs way of doing this, I
don't
> know, it's a matter of taste.  Here's a Rube Goldbergesque way: when the
> client registers, export a dynamically allocated major number through
proc
> and let the user mknod a device with that major.

Yes I think, that would be a great alternative, using good old /proc.

Constantin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/




