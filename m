Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293627AbSCSDgh>; Mon, 18 Mar 2002 22:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293626AbSCSDg3>; Mon, 18 Mar 2002 22:36:29 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60168 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293619AbSCSDgR>;
	Mon, 18 Mar 2002 22:36:17 -0500
Message-ID: <3C96B207.8060006@mandrakesoft.com>
Date: Mon, 18 Mar 2002 22:35:35 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: 7.52 second kernel compile
In-Reply-To: <20020318153637.J4783@host110.fsmlabs.com> <Pine.LNX.4.33.0203181446200.10517-100000@penguin.transmeta.com> <15510.32200.595707.145452@argo.ozlabs.ibm.com> <20020319015722.N17410@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

>On Tue, Mar 19, 2002 at 10:52:40AM +1100, Paul Mackerras wrote:
> > The G4 has 4 performance monitor counters that you can set up to
> > measure things like ITLB misses, DTLB misses, cycles spent doing
> > tablewalks for ITLB misses and DTLB misses, etc.
> > What I need to do now is
> > to put some better infrastructure for using those counters in place
> > and try your program using those counters instead of the timebase.
>
> Sounds like a good candidate for the first non-x86 port of oprofile[1].
> Write the kernel part, and all the nice userspace tools come for free.
> There are also a few other perfctr abstraction projects, which are
> linked off the oprofile pages somewhere iirc.
>

Maybe this is why drepper doesn't like threaded profiling... he wants us 
all to use oprofile.

/me ducks and runs....




