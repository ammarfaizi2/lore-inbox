Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263986AbSITXWa>; Fri, 20 Sep 2002 19:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263988AbSITXWa>; Fri, 20 Sep 2002 19:22:30 -0400
Received: from packet.digeo.com ([12.110.80.53]:9673 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263986AbSITXW3>;
	Fri, 20 Sep 2002 19:22:29 -0400
Message-ID: <3D8BAEDC.ED943632@digeo.com>
Date: Fri, 20 Sep 2002 16:27:24 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org, msinz@wgate.com
Subject: Re: [PATCH] kernel 2.4.19 & 2.5.38 - coredump sysctl
References: <3D8B87C7.7040106@wgate.com.suse.lists.linux.kernel> <3D8B8CAB.103C6CB8@digeo.com.suse.lists.linux.kernel> <3D8B934A.1060900@wgate.com.suse.lists.linux.kernel> <3D8B982A.2ABAA64C@digeo.com.suse.lists.linux.kernel> <p73bs6stfv8.fsf@oldwotan.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Sep 2002 23:27:29.0027 (UTC) FILETIME=[4929E530:01C260FD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> Andrew Morton <akpm@digeo.com> writes:
> 
> > True, but it's all more code and I don't believe that it adds
> > much value.  It means that people need to run off and find
> 
> One useful feature of it would be that you can get core dumps for
> each thread by including the pid (or tid later with newer threading libraries)
> Currently threads when core dumping overwrite each others cores so you lose
> the registers of all but one.

Oh sure, I agree that it's a useful feature.  But I don't agree that
we need to allow users to specify how the final filename is pasted
together.  Just give them host-uid-gid-comm.core.  ie: everything.
