Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289009AbSA3J1Q>; Wed, 30 Jan 2002 04:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289010AbSA3J1G>; Wed, 30 Jan 2002 04:27:06 -0500
Received: from mx1.sac.fedex.com ([199.81.208.10]:46853 "EHLO
	mx1.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S289009AbSA3J04>; Wed, 30 Jan 2002 04:26:56 -0500
Date: Wed, 30 Jan 2002 17:22:47 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Thomas Hood <jdthood@yahoo.co.uk>
cc: Jeff Chua <jeffchua@silk.corp.fedex.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: 2.4.18-pre7 slow ... apm problem
In-Reply-To: <1012353152.4807.146.camel@thanatos>
Message-ID: <Pine.LNX.4.44.0201301721180.3268-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 01/30/2002
 05:26:52 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 01/30/2002
 05:26:54 PM,
	Serialize complete at 01/30/2002 05:26:54 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 29 Jan 2002, Thomas Hood wrote:

> On Tue, 2002-01-29 at 07:36, Jeff Chua wrote:
> > Ok got it. But still have to reboot machine as the apm is loaded and can't
> > "rmmod apm". Complained that it's in use ([kapmd] even after stopping
> > apmd.
>
> That's a bug, I think.  You should be able to rmmod the apm module.

found the reason why I can't rmmod apm ... xfree is using it. If I start
Xfree first, then modprobe apm, then I can rmmod apm.

Jeff.


