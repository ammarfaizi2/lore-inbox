Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313102AbSDEQyg>; Fri, 5 Apr 2002 11:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313113AbSDEQy0>; Fri, 5 Apr 2002 11:54:26 -0500
Received: from tolkor.sgi.com ([192.48.180.13]:50925 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S313102AbSDEQyN>;
	Fri, 5 Apr 2002 11:54:13 -0500
Message-ID: <3CADD6CA.8010600@sgi.com>
Date: Fri, 05 Apr 2002 10:54:34 -0600
From: Stephen Lord <lord@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: svetljo <galia@st-peter.stw.uni-erlangen.de>, linux-kernel@vger.kernel.org,
        linux-xfs@thebarn.com
Subject: Re: REPOST : linux-2.5.5-xfs-dj1 - 2.5.7-dj2  (raid0_make_request bug)
In-Reply-To: <3CAD8B9D.8070902@st-peter.stw.uni-erlangen.de> <20020405184103.F14828@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

>On Fri, Apr 05, 2002 at 01:33:49PM +0200, svetljo wrote:
> > i'm having some interesting troubles
> > i have lvm over soft RAID-0 with LV's formated with XFS and JFS
> > i can work with the JFS LV's,
> >    but i can not with the XFS one's, i can not mount them ( no troubles
> > with XFS normal partitions)
> > so i'd like to ask is this problem with XFS or with raid or lvm
> > and is there a way to fix it
>
>IIRC, this was reported a while ago, and it was something to do with
>XFS creating too large requests that upset the raid code.
>
Or the raid code not handling the bio layer too well, depends on your point
of view ;-)

Steve



