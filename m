Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265379AbRGLOaA>; Thu, 12 Jul 2001 10:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265431AbRGLO3u>; Thu, 12 Jul 2001 10:29:50 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:58527 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S265379AbRGLO3j>; Thu, 12 Jul 2001 10:29:39 -0400
Date: Thu, 12 Jul 2001 09:29:05 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200107121429.JAA66935@tomcat.admin.navo.hpc.mil>
To: justin@soze.net, Nitin Dhingra <nitin.dhingra@dcmtech.co.in>
Subject: Re: IPsec in Kernel??
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Guyett <justin@soze.net>:
> On Thu, 12 Jul 2001, Nitin Dhingra wrote:
> 
> > Is there any possibility that IPsec will be provided in
> > the kernel ?
> 
> The maintainers won't accept code from anyone in the US for fear that
> export regulations may tighten again retroactively, so any merge into the
> kernel would require a seperate maintainer either to maintain the fork,
> and/or to constantly merge in new changes from the original freeswan
> project.
> 
> The current in-kernel portion of freeswan doesn't get along well with
> advanced routing, and doesn't take advantage of SMP, so I'd be rather
> disappointed if it got forked and merged in its current form.
> 
> Some things that would be nice:
>  integration with advanced routing
>  /proc interface so connections can be added on the fly
>  module-only option (freeswan's latest snapshots seem to have this)
>  take advantage of SMP
>  implement AES
>  use of kernel crypto patch / openssl for userland rsa stuff
>  move all non-optional parts of the updown scripts into the ipsec program,
>   a la openbsd where the shell script portion isn't hundreds of lines for
>   one tunnel.
>  no bloat (a 3.5 meg ipsec module doesn't seem very reasonable)

It also needs to support more than just encrypted IP tunnels.

I'm hoping the Linux security module will eventually be able to have modules
for IPSec plus remote user authentication, socket/data labeling.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
