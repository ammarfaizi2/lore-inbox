Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276495AbRI2NPY>; Sat, 29 Sep 2001 09:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276496AbRI2NPO>; Sat, 29 Sep 2001 09:15:14 -0400
Received: from mx5.sac.fedex.com ([199.81.194.37]:41480 "EHLO
	mx5.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S276495AbRI2NPI>; Sat, 29 Sep 2001 09:15:08 -0400
Date: Sat, 29 Sep 2001 21:17:11 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: <root@boston.corp.fedex.com>
To: Nicholas Knight <tegeran@home.com>
cc: Jeff Chua <jeffchua@silk.corp.fedex.com>,
        David Lang <david.lang@digitalinsight.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2 GB file limitation
In-Reply-To: <20010929112129.UGYL674.femail40.sdc1.sfba.home.com@there>
Message-ID: <Pine.LNX.4.33.0109292115220.12029-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 09/29/2001
 09:15:31 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 09/29/2001
 09:15:33 PM,
	Serialize complete at 09/29/2001 09:15:33 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Sep 2001, Nicholas Knight wrote:

> On Friday 28 September 2001 05:18 pm, Jeff Chua wrote:
> > On Fri, 28 Sep 2001, David Lang wrote:
> > > ?? slackware 8 has large file support (I've been useing it for a
> > > while now)
> >
> > I think you can get >2GB support if you've Gcc 3.0. Even with the
> > latest kernel 2.4.x, you won't get >2GB with gcc 2.95.3.
>
> Could have fooled me with my 2.95.3 and 2.95.4 systems and their 3GB+
> files.
> -

uh, I mistaken glib2.2 for gcc. sorry (see below from Chris).

Jeff.



On Fri, 28 Sep 2001, Christopher Zimmerman wrote:
> Actually you just need glibc2.2 and compile your apps with these
flags:
> -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -DLARGE_FILES


