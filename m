Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290629AbSBLAUl>; Mon, 11 Feb 2002 19:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290634AbSBLAUb>; Mon, 11 Feb 2002 19:20:31 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42512 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S290629AbSBLAUN>;
	Mon, 11 Feb 2002 19:20:13 -0500
Message-ID: <3C685FBA.A9D60B3A@mandrakesoft.com>
Date: Mon, 11 Feb 2002 19:20:10 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Robert Love <rml@tech9.net>, Luigi Genoni <kernel@Expansa.sns.it>,
        Arkadiy Chapkis - Arc <achapkis@mail.dls.net>,
        LINUX-KERNEL@vger.kernel.org
Subject: Re: thread_info implementation
In-Reply-To: <Pine.LNX.4.44.0202112140280.6590-100000@Expansa.sns.it> <1013460534.6784.477.camel@phantasy> <3C6855A2.4721DDD3@mandrakesoft.com> <20020211154917.A19367@are.twiddle.net> <20020212010911.O4285@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> 
> On Mon, Feb 11, 2002 at 03:49:17PM -0800, Richard Henderson wrote:
> 
>  > Though I seem to be having some problems with NFS.  Mount goes into D
>  > state for quite some time and the portmapper complains about timeouts
>  > connecting to localhost.  Anyone else see anything like that?  I suppose
>  > I'll build an x86 kernel from the same source and see what I can find...
> 
>  Yes. I saw this start happening in my tree when I merged 2.5.4pre2
>  When I tried a 2.5.4pre2 vanilla, the problem was gone, so I put it
>  down to a problem in my tree. When I rebooted back into it, the problem
>  was gone. Aren't heisenbugs fun?
>  Exactly the same symptoms, portmap borken, NIS/NFS subsequently fail.

/etc/nsswitch.conf set up correctly?  /etc/host.conf?

I notice that newer RH and MDK initscripts require a bunch of stuff like
netlink devices and ipv6 support, make sure you have those enabled
too...

	Jeff



-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
