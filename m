Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264708AbSIQXxn>; Tue, 17 Sep 2002 19:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264724AbSIQXxn>; Tue, 17 Sep 2002 19:53:43 -0400
Received: from ns.suse.de ([213.95.15.193]:13828 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S264708AbSIQXxm>;
	Tue, 17 Sep 2002 19:53:42 -0400
Date: Wed, 18 Sep 2002 01:58:38 +0200
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: ak@suse.de, johnstul@us.ibm.com, jamesclv@us.ibm.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       anton.wilson@camotion.com
Subject: Re: do_gettimeofday vs. rdtsc in the scheduler
Message-ID: <20020918015838.A6684@wotan.suse.de>
References: <1032305535.7481.204.camel@cog> <20020917.163246.113965700.davem@redhat.com> <20020918015209.B31263@wotan.suse.de> <20020917.164649.110499262.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020917.164649.110499262.davem@redhat.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2002 at 04:46:49PM -0700, David S. Miller wrote:
>    From: Andi Kleen <ak@suse.de>
>    Date: Wed, 18 Sep 2002 01:52:09 +0200
> 
>    On Tue, Sep 17, 2002 at 04:32:46PM -0700, David S. Miller wrote:
>    > I know full well it isn't currently :-)
>    
>    Sorry, it's wrong. The x86 architecture has several such registers
> 
> Not in the processor, and not architectually specified.
> 
> All of the things you list are in the scope of things outside
> the cpu.

The local APIC timer is specified in the Intel Manual volume 3 for example.
It's an optional feature (CPUID), but pretty much everyone has it.

-Andi



