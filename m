Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbUCEBAf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 20:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262141AbUCEBAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 20:00:35 -0500
Received: from fe5-cox.cox-internet.com ([66.76.2.50]:37761 "EHLO
	fe5.cox-internet.com") by vger.kernel.org with ESMTP
	id S262131AbUCEBAd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 20:00:33 -0500
Content-Type: text/plain; charset=US-ASCII
From: Billy Rose <billyrose@cox-internet.com>
To: krishnakumar@naturesoft.net, Tim Bird <tim.bird@am.sony.com>
Subject: Re: kernel mode console
Date: Thu, 4 Mar 2004 18:58:45 -0600
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <200403022152.06950.billyrose@cox-internet.com> <40460C8E.4010100@am.sony.com> <200403040942.23176.krishnakumar@naturesoft.net>
In-Reply-To: <200403040942.23176.krishnakumar@naturesoft.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200403041858.45617.billyrose@cox-internet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 March 2004 10:12 pm, Krishnakumar. R wrote:
> Hi,
>
> > set up a remote debug session just to poke around in the kernel.
> > Remote debug setup is complex and often fragile.
>
> There is framework called "Kprobes" available, which may
> be of use in the cases were remote debugging is a no-no.
>
> After you have applied the kprobes patch, you can put probes
> at different portions of the kernel and can dump registers
> variables etc.
>
> More details can be found at
> http://www-124.ibm.com/linux/projects/kprobes.
>
>
> Regards,
> KK.

i think perhaps i need to expound upon what i have a vision of. a kernel mode 
console is just that: a console designed to run in kernel mode. it could have 
built in commands to allow for quick and dirty examination of stuff (anything 
really, like memory dumps) and a command processor for scripted stuff, but 
the true power of it comes in when you issue a command that is not internal 
to the console. it could run a special debugger, an application that installs 
a probe, a memory monitor, etc., etc. in short it is not a debugger per-say, 
but a "god mode" console for the linux kernel. that is what i had a vision 
of. the executables it would run would necessarily be compiled for that. 
again, i ask is that worth the time coding it?
-- 
. ~billyrose/make
