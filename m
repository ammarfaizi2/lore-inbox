Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310718AbSCHHyr>; Fri, 8 Mar 2002 02:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310719AbSCHHyh>; Fri, 8 Mar 2002 02:54:37 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:40553 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S293680AbSCHHyU>; Fri, 8 Mar 2002 02:54:20 -0500
Date: Fri, 8 Mar 2002 02:54:15 -0500
From: Arjan van de Ven <arjanv@redhat.com>
To: Hank Yang <hanky@promise.com.tw>
Cc: arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Submitting PROMISE IDE Controllers Driver Patch
Message-ID: <20020308025415.B29763@devserv.devel.redhat.com>
In-Reply-To: <014701c1c5b6$a0dfb620$59cca8c0@hank> <3C873F96.C91E3591@redhat.com> <00b901c1c642$e7b6e9b0$59cca8c0@hank>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <00b901c1c642$e7b6e9b0$59cca8c0@hank>; from hanky@promise.com.tw on Fri, Mar 08, 2002 at 09:45:15AM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2002 at 09:45:15AM +0800, Hank Yang wrote:
> Hello.
> 
>     That's because the linux-kernel misunderstand the raid controller
> to IDE controller. If do so, The raid driver will be unstable when
> be loaded.
> 
>     So we must to prevent the raio controller to be as IDE controller
> here.

the in-kernel raid driver requires the IDE controller to be seen by the kernel.
If you have an alternative raid driver please send me the source
so I can probably fix this case for you.

