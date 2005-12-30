Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964973AbVL3X4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964973AbVL3X4o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 18:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbVL3X4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 18:56:43 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:36504 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S964973AbVL3X4n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 18:56:43 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Mark v Wolher <trilight@ns666.com>
Subject: Re: system keeps freezing once every 24 hours / random apps crashing
Date: Fri, 30 Dec 2005 23:56:59 +0000
User-Agent: KMail/1.9
Cc: Lee Revell <rlrevell@joe-job.com>,
       Folkert van Heusden <folkert@vanheusden.com>,
       Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <43B53EAB.3070800@ns666.com> <200512302311.27125.s0348365@sms.ed.ac.uk> <43B5C5F6.5070500@ns666.com>
In-Reply-To: <43B5C5F6.5070500@ns666.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512302356.59749.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 30 December 2005 23:42, Mark v Wolher wrote:
> Alistair John Strachan wrote:
> > On Friday 30 December 2005 22:16, Mark v Wolher wrote:
> > [snip]
> >
> >>>Basically you are asking for help with an unsupported configuration.  In
> >>>general people on LKML will be more helpful if you take the time to find
> >>>out what the bug reporting guidelines are before posting.
> >>>
> >>>Lee
> >>
> >>Thank you for your input, but sometimes thinking out of the box gives a
> >>solution instead of hiding behind "guidelines".
> >
> > I'm surprised Lee fed you this long, but the cold hard fact of the matter
> > is that you are posting to the Linux kernel mailing lists, and you will
> > comply with these guidelines if you expect help.
> >
> > I'm sure the problem might not be with VMWare, but there is absolutely
> > nothing stopping you from switching nvidia with nv, not loading
> > nvidia/vmware modules, then running the TV card doing *something else*
> > for a few hours. If you do not detect lockups, contact VMWare. They will
> > probably do the exact opposite of what Lee has done and suggest
> > non-VMWare parts of the system are at fault.
> >
> > However, unlike VMWare or NVIDIA, we can actually debug problems if you
> > use source-available modules. Thinking outside of the box here is
> > irrelevant -- a problem requires logical procedure to gain a solution.
> > Any engineer will tell you the same thing. Ordinarily, this is test,
> > observe, retest, and all Lee is suggesting is that you do *not* load the
> > proprietary modules.
> >
> > Try it before responding to this email, so you do not have to write
> > another.
>
> I already switched nvidia for the nv driver in the kernel. Also disabled
> by unloading all modules.

As Lee already explained, "unloading" is insufficient. If you continue to 
argue that it is sufficient, then you are only exposing your own ignorance of 
the issues at hand. Please physically delete the modules so that they cannot 
ever be loaded by the kernel during or after bootup, then reboot the machine 
before testing.

> You're saying i should then see what happens after doing the above ...
> This is exactly what i'm now doing, tvcard is active (tv) and i'm doing
> some work as usual. I get the feeling some people consider everyone who
> is a bit different in approach as either some newbie or an idiot, well
> wake up, sometimes by looking from a different view at a problem it can
> be solved. This doesn't mean i don't appreciate the advise of Lee or
> yours, i only ask for some patience. It's not like the world is going
> under if we don't solve this in an hour with traditional logic. :)

Feel free to try any method you like, but the method myself and Lee have 
stated is the only one acceptable on this list.

> And at this point the system is still working, i'm increasing the load
> by making it crush numbers, doing a full virusscan and so on.

This is good news -- you stand a better chance of achieving the stability you 
require by eliminating variables. VMWare and NVIDIA are useful softwares, and 
I would not deny that, but they are closed source and thus any conflicts 
resulting from their use are not necessary LKML material (however, if the 
interaction is generic and is as a result of a kernel bug, then the 
maintainer would very much like to hear it).

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
