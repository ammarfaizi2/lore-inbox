Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264079AbTICSFV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 14:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264115AbTICSFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 14:05:20 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:61967
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S264079AbTICSFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 14:05:03 -0400
Date: Wed, 3 Sep 2003 10:49:19 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: James Clark <jimwclark@ntlworld.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Driver Model 2 Proposal - Linux Kernel Performance v Usability
In-Reply-To: <200309031850.14925.jimwclark@ntlworld.com>
Message-ID: <Pine.LNX.4.10.10309031043410.13722-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


James,

You missed a key point, the kernel people do not give a damn about binary
modules and think they are evil.  They do not care if a binary module
works at all.  If they can break it they will.  You are wasting time and
electrons, or just pee'ng in the wind.

The only solution is to created a GPL pre-loading module with all the
GPL_ONLY needed extentions re-exported or externed as to bypass the horse
sh*t.

What I am shocked to see is how people are being nice to you and not
blasting you with a carpet bomb attack.  I guess they are waiting to line
up on me.

Cheers,

Andre



On Wed, 3 Sep 2003, James Clark wrote:

> Following my initial post yesterday please find attached my proposal for a 
> binary 'plugin' interface:
> 
> This is not an attempt to have a Microkernel, or any move away from GNU/OSS 
> software. I believe that sometimes the ultimate goals of stability and 
> portability get lost in the debate on OSS and desire to allow anyone to 
> contribute. It is worth remembering that for every Kernel hacker there must 
> be 1000's of plain users. I believe this proposal would lead to better 
> software and more people using it.
> 
> Proposal
> -----------
> 1. Implement binary kernel 'plugin' interface
> 2. Over time remove most existing kernel 'drivers' to use new interface - This 
> is NOT a Microkernel.
> 3. Design 'plugin' interface to be extensible as possible and then rarely 
> remove support from interface. Extending interface is fine but should be done 
> in a considered way to avoid interface bloat. Suggest interface supports 
> dependant 'plugins'
> 4. Allow 'plugins' to be bypassed at boot - perhaps a minimal 'known good' 
> list
> 5. Ultimately, even FS 'plugins' could be created although IPL would be 
> required to load these. 
> 6. Code for Kernel, Interface and 'plugins' would still be GPL. This would not 
> prevent the 'tainted' system idea. 
> 
> Expected Outcomes
> ------------------------
> 
> 1. Make Linux easier to use
> 2. The ability to replace even very core Kernel components without a restart.
> 3. Allow faulty 'plugins' to be fixed/replaced in isolation. No other system 
> impact.
> 4. 'Plugins' could create their own interfaces as load time. This would remove 
> the need to pre-populate /dev. 
> 5. Remove need for joe soap user to often recompile Kernel.
> 6. Remove link between specific module versions and Kernel versions.
> 7. Reduce need for major Kernel releases. Allow effort to concentrate on 
> improving Kernel not maintaining ever increasing Kernel source that includes 
> support for the 'Kitchen Sink'
> 8. Make core Kernel more stable. Less releases and less changes mean less 
> bugs. It would be easy to identify offending 'plugin' by simply starting up 
> the Kernel with it disabled.
> 9. Remove need for modules to be maintained in sync with each Kernel thus 
> freeing 'module' developers to add improved features or work on new projects.
> 
> James
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


