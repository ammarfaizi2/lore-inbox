Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264994AbSIRCLd>; Tue, 17 Sep 2002 22:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265002AbSIRCLd>; Tue, 17 Sep 2002 22:11:33 -0400
Received: from packet.digeo.com ([12.110.80.53]:54750 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264994AbSIRCLb>;
	Tue, 17 Sep 2002 22:11:31 -0400
Message-ID: <3D87E1F9.33909AC8@digeo.com>
Date: Tue, 17 Sep 2002 19:16:25 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: hadi@cyberus.ca, manfred@colorfullife.com, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: Info: NAPI performance at "low" loads
References: <Pine.GSO.4.30.0209172053360.3686-100000@shell.cyberus.ca> <20020917.180014.07882539.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Sep 2002 02:16:25.0821 (UTC) FILETIME=[63ECA8D0:01C25EB9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    From: jamal <hadi@cyberus.ca>
>    Date: Tue, 17 Sep 2002 20:57:58 -0400 (EDT)
> 
>    I am not so sure with that 6% difference there is no other bug lurking
>    there; 6% seems too large for an extra two PCI transactions per packet.
> 
> {in,out}{b,w,l}() operations have a fixed timing, therefore his
> results doesn't sound that far off.
> 
> It is also one of the reasons I suspect Andrew saw such bad results
> with 3c59x, but probably that is not the only reason.

They weren't "very bad", iirc.  Maybe a 5% increase in CPU load.

It was all a long time ago.  Will retest if someone sends URLs.
