Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264593AbSIQV1S>; Tue, 17 Sep 2002 17:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264619AbSIQV1S>; Tue, 17 Sep 2002 17:27:18 -0400
Received: from packet.digeo.com ([12.110.80.53]:38870 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264593AbSIQV1R>;
	Tue, 17 Sep 2002 17:27:17 -0400
Message-ID: <3D879F59.6BDF9443@digeo.com>
Date: Tue, 17 Sep 2002 14:32:09 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: manfred@colorfullife.com, linux-netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: Info: NAPI performance at "low" loads
References: <3D87881F.4070808@colorfullife.com> <20020917.135939.52477700.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Sep 2002 21:32:09.0195 (UTC) FILETIME=[AD6213B0:01C25E91]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    From: Manfred Spraul <manfred@colorfullife.com>
>    Date: Tue, 17 Sep 2002 21:53:03 +0200
> 
>    Receiver:
>      $ loadtest
> 
> This appears to be x86 only, sorry I can't test this out for you as
> all my boxes are sparc64.
> 
> I was actually eager to try your tests out here.
> 
> Do you really need to use x86 instructions to do what you
> are doing?  There are portable pthread mutexes available.

There is a similar background loadtester at
http://www.zip.com.au/~akpm/linux/#zc .

It's fairly fancy - I wrote it for measuring networking
efficiency.  It doesn't seem to have any PCisms....

(I measured similar regression using an ancient NAPIfied
3c59x a long time ago).
