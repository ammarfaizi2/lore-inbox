Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318407AbSHPOuy>; Fri, 16 Aug 2002 10:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318426AbSHPOuy>; Fri, 16 Aug 2002 10:50:54 -0400
Received: from waste.org ([209.173.204.2]:52941 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S318407AbSHPOux>;
	Fri, 16 Aug 2002 10:50:53 -0400
Date: Fri, 16 Aug 2002 09:54:34 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Dax Kelson <dax@gurulabs.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Will NFSv4 be accepted?
Message-ID: <20020816145434.GD5418@waste.org>
References: <Pine.LNX.4.44.0208141938350.31203-100000@mooru.gurulabs.com> <Pine.LNX.4.44.0208151027510.3130-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208151027510.3130-100000@home.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2002 at 10:35:40AM -0700, Linus Torvalds wrote:
> 
> I personally doubt that NFS would be the thing driving this. Judging by 
> past performance, NFS security issues don't seem to bother people. I'd 
> personally assume that the thing that would be important enough to people 
> for vendors to add it is VPN or encrypted (local) disks.

I would have thought that there'd be a big push for merging IPSEC in as it
creates one of those "network effects" but it's still stalled by
politics. I think they're waiting for a written invitation or something.

Is loopback solid enough currently to make crypto over loopback
worthwhile? It's occurred to me that it might be better to move the
translation hooks down to the generic block layer proper so that
things like LVM and iSCSI and brain-damaged bit-swapped IDE could take
advantage of them without the deadlock-prone layering issues of
loopback. Thoughts?

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
