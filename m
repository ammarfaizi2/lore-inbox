Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272169AbTHRRxl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 13:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272216AbTHRRxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 13:53:41 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:19207 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S272169AbTHRRxa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 13:53:30 -0400
From: Michael Frank <mhf@linuxmail.org>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: Dumb question: Why are exceptions such as SIGSEGV not logged
Date: Tue, 19 Aug 2003 01:52:29 +0800
User-Agent: KMail/1.5.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <200308170410.30844.mhf@linuxmail.org> <20030818143146.GV32488@holomorphy.com>
In-Reply-To: <20030818143146.GV32488@holomorphy.com>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308190152.29370.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 August 2003 22:31, William Lee Irwin III wrote:
> On Sun, Aug 17, 2003 at 04:10:30AM +0800, Michael Frank wrote:
> > Linux logs almost everything, why not exceptions such as SIGSEGV in
> > userspace which may be very informative?
>
> Such exceptions are part of the normal operation of certain kinds of
> programs, such as ones using (nowadays unusual) certain garbage
> collection algorithms. I actually installed such a beast (Lisp system)
> in no small part so it would exercise "invalid" memory accesses and
> test various bits of VM code related to such. For other VM people
> interested in it, there's an sbcl debian package that recompiles a
> moderately sized chunk of Lisp code and hence runs the system at
> install-time, and so exercises the SIGSEGV path rather heavily on
> 32-bit systems and/or systems with <= 2GB of RAM. No particular
> intervention apart from (re)installing it is required to pound the
> SIGSEGV path like a wild monkey, so it's actually a very convenient
> touch test for such things.

I am thinking along the line of "Exceptions" rather than "normal events"
by specific applications. 

I tend to see segfaults only when something is broken or when my lapse of 
attention perhaps should be rewarded by said "sucker rod".

The current application to trap SIGSEGV when something is badly broken 
can be found here: 
http://marc.theaimsgroup.com/?l=swsusp-devel&m=106121712521861&w=2

Regards
Michael

-- 
Powered by linux-2.6. Compiled with gcc-2.95-3 - mature and rock solid

2.4/2.6 kernel testing: ACPI PCI interrupt routing, PCI IRQ sharing, swsusp
2.6 kernel testing:     PCMCIA yenta_socket, Suspend to RAM with ACPI S1-S3

More info on swsusp: http://sourceforge.net/projects/swsusp/

