Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262667AbSJJAB5>; Wed, 9 Oct 2002 20:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262414AbSJJAB5>; Wed, 9 Oct 2002 20:01:57 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:25486 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262382AbSJJABx>;
	Wed, 9 Oct 2002 20:01:53 -0400
Subject: Re: Why NFS server does not pass lock requests via VFS lock() op?
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-kernel-owner@vger.kernel.org,
       nfs@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.2a (Intl) 23 November 1999
Message-ID: <OFAB5FE3E3.3D571A56-ON87256C4D.008352AE@us.ibm.com>
From: Juan Gomez <juang@us.ibm.com>
Date: Wed, 9 Oct 2002 17:07:19 -0700
X-MIMETrack: Serialize by Router on D03NM694/03/M/IBM(Release 6.0|September 26, 2002) at
 10/09/2002 18:07:18
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Oh ok. Well can we resuscitate this patch? The AFS NAS head example is a
good reason to do this.
If you need any help please let me know and I will be happy to test/adapt
the patch in/to the version that you may want to apply it.
We have one version for 2.4.18 that someone created recently if the one you
have is too old...

Thanks, Juan




|---------+---------------------------------->
|         |           Alan Cox               |
|         |           <alan@lxorguk.ukuu.org.|
|         |           uk>                    |
|         |           Sent by:               |
|         |           linux-kernel-owner@vger|
|         |           .kernel.org            |
|         |                                  |
|         |                                  |
|         |           10/09/02 04:32 PM      |
|         |                                  |
|---------+---------------------------------->
  >-----------------------------------------------------------------------------------------------------------------------------|
  |                                                                                                                             |
  |       To:       Juan Gomez/Almaden/IBM@IBMUS                                                                                |
  |       cc:       nfs@lists.sourceforge.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>                         |
  |       Subject:  Re: Why NFS server does not pass lock requests via VFS lock() op?                                           |
  |                                                                                                                             |
  |                                                                                                                             |
  >-----------------------------------------------------------------------------------------------------------------------------|



On Thu, 2002-10-10 at 00:11, Juan Gomez wrote:
>
>
>
>
> Could anyone remind me of why NFS kernel would not pass byte range lock
> requests to the underlying filsystem at the server side?
> I think another person at IBM (Brian?) submitted a patch for this but
such
> patch never got included in the distribution.

I know Matthew had the patches, and I know I looked at them and they
seemed sane enough. But I don't know where they eventually went. Things
like NFS over AFS are going to need it

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



