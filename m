Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317772AbSHUDSm>; Tue, 20 Aug 2002 23:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317778AbSHUDSm>; Tue, 20 Aug 2002 23:18:42 -0400
Received: from mx3.sac.fedex.com ([199.81.208.11]:62212 "EHLO
	mx3.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S317772AbSHUDSl>; Tue, 20 Aug 2002 23:18:41 -0400
Date: Wed, 21 Aug 2002 11:21:04 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Erik Andersen <andersen@codepoet.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-pre4 + LVM = hosed /proc/partitions
In-Reply-To: <20020821030430.GA11994@codepoet.org>
Message-ID: <Pine.LNX.4.44.0208211118270.6828-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 08/21/2002
 11:22:29 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 08/21/2002
 11:22:46 AM,
	Serialize complete at 08/21/2002 11:22:46 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 20 Aug 2002, Erik Andersen wrote:

> On Tue Aug 20, 2002 at 08:27:32PM -0600, Erik wrote:
> > Try compiling CONFIG_BLK_DEV_LVM into 2.4.20-pre4 and then run
> > 'cat /proc/partitions' for some amusement. I really like the way
>
> It also seems to occur for md and ataraid.

You should consider switching to LVM2. LVM2 doesn't have such problem, and
it seems more stable too.

Jeff


