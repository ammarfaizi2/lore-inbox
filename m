Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132754AbRC2PRW>; Thu, 29 Mar 2001 10:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132743AbRC2PRM>; Thu, 29 Mar 2001 10:17:12 -0500
Received: from zeus.kernel.org ([209.10.41.242]:46036 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S132744AbRC2PRC>;
	Thu, 29 Mar 2001 10:17:02 -0500
Date: Thu, 29 Mar 2001 10:05:27 -0500
From: Eric Buddington <eric@sparrow.nad.adelphia.net>
To: Ulrich Drepper <drepper@cygnus.com>
Cc: ebuddington@mail.wesleyan.edu, Brian Gerst <bgerst@didntduck.org>,
   linux-kernel@vger.kernel.org
Subject: Re: 386 'ls' gets SIGILL iff /proc is mounted
Message-ID: <20010329100527.P80@sparrow.nad.adelphia.net>
Reply-To: ebuddington@wesleyan.edu
In-Reply-To: <20010327012709.I59@sparrow.nad.adelphia.net> <3AC09F14.53D06AC7@didntduck.org> <20010327091205.B80@sparrow.nad.adelphia.net> <3AC0A21B.438EFE02@didntduck.org> <20010328124845.I80@sparrow.nad.adelphia.net> <m3wv99vk8o.fsf@otr.mynet.cygnus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m3wv99vk8o.fsf@otr.mynet.cygnus.com>; from drepper@redhat.com on Wed, Mar 28, 2001 at 10:09:11AM -0800
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2001 at 10:09:11AM -0800, Ulrich Drepper wrote:
> Eric Buddington <eric@sparrow.nad.adelphia.net> writes:
> 
> > OK. Context again (since I clipped preceding notes): 386SX/20 nfsroot,
> > getting SIGILL on lots of processes, math emulation is enabled, ls and
> > glibc were compiled with '-march=i386 -mcpu=i386' to be sure.
> 
> This isn't enough.  You compiled glibc on a i586 or later without
> telling configure to use the i386 configuration.  Run configure with
> the usual options and
> 
>    i386-linux-gnu
> 
> at the end of the command line and then use the options above.

This seems to have solved the problem. Thanks!

-Eric
