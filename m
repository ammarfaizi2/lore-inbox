Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314074AbSDKO1W>; Thu, 11 Apr 2002 10:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314075AbSDKO1V>; Thu, 11 Apr 2002 10:27:21 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:28356 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S314074AbSDKO1U>; Thu, 11 Apr 2002 10:27:20 -0400
Date: Thu, 11 Apr 2002 19:58:34 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Jeremy Jackson <jerj@coplanar.net>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, linux-kernel@vger.kernel.org,
        lkcd-devel@lists.sourceforge.net
Subject: Re: Faster reboots (and a better way of taking crashdumps?)
Message-ID: <20020411195834.C1947@in.ibm.com>
Reply-To: suparna@in.ibm.com
In-Reply-To: <00c501c1dce3$0ed806d0$7e0aa8c0@bridge> <1674141067.1018028922@[10.10.2.3]> <003301c1dd16$855df1b0$7e0aa8c0@bridge> <3CB144BE.9DC8B034@in.ibm.com> <007b01c1e10b$93b27300$7e0aa8c0@bridge>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2002 at 08:47:17PM -0700, Jeremy Jackson wrote:
> Should this go off lkml?

Should be ok to continue - I just wanted to make sure lkcd-devel 
is in the loop too, since many of us don't monitor lkml that 
closely all the time.

> 
> ----- Original Message ----- 
> From: "Suparna Bhattacharya" <suparna@in.ibm.com>
> Sent: Monday, April 08, 2002 12:20 AM
>  
> > > I'm currently researching combining the two, to create a LinuxBIOS
> > > firmware debug console, which will allow complete crash dump to
> > > be taken after a hardware reset, with the smallest possible Heisenburg
> > > effect, aside from a hardware debugger.
> > 
> > So how is the actual writeout accomplished ?(via LinuxBIOS ?)
> 
> well it's just an idea just now. In order to do this from code in rom,
> I immagine it would just dump physical memory to a raw partition,
> using polling ide drivers in LinuxBIOS.  This is probably a step

OK. There have been plans to do this via polling drivers in software,
but guess if you can handle it at the LinuxBIOS level the impact may 
be still lower. 

> backwards, compared to modern crash dumps, but it would
> allow zero alteration of memory.
> 
> It may be possible to do with a standard flash size of 128KiB,
> though, which would allow virtually all motherboards to support it.
> 
> Jeremy
