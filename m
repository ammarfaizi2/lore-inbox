Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264579AbUDVROp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264579AbUDVROp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 13:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264583AbUDVROp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 13:14:45 -0400
Received: from [63.161.72.3] ([63.161.72.3]:29898 "EHLO
	mail.standardbeverage.com") by vger.kernel.org with ESMTP
	id S264579AbUDVROk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 13:14:40 -0400
Message-ID: <2600528e2c678fd4f78a49642b2f701c@stdbev.com>
Date: Thu, 22 Apr 2004 12:27:09 -0500
From: "Jason Munro" <jason@stdbev.com>
Subject: Re: ACPI suspend to RAM weirdness
To: "Len Brown" <len.brown@intel.com>
Reply-to: <jason@stdbev.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1082653671.16332.339.camel@dhcppc4>
References: <A6974D8E5F98D511BB910002A50A6647615F9797@hdsmsx403.hd.intel.com>
            <1082653671.16332.339.camel@dhcppc4>
X-Mailer: Hastymail 1.0-rc2-CVS
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12:07:51 pm 04/22/04 Len Brown <len.brown@intel.com> wrote:
> On Thu, 2004-04-22 at 12:24, Jason Munro wrote:
> >  Hello all,
> >     I can sucessfully suspend with 'echo 3 > /proc/acpi/sleep' on my
> >  Toshiba
> >  Satellite 1410-S173. It also wakes up fine, except after waking it
> >  jumps to
> >  init 0 and shuts down. It's been this way with every kernel I have
> >  tried
> >  since 2.6.4. I know it worked with 2.6.1 but I'm not sure exactly
> >  at what
> >  point between that and 2.6.4 it changed, or even if this is a
> >  userspace or
> >  kernel issue. Yesterday I tried with 2.6.6-rc2 and rc2-mm1 and it
> >  still
> >  behaves the same.
>
> We have some event/wakeup GPE weirdness lately.
> You might try working around it by shutting down acpid
> before you suspend -- it may be processing your wakeup
> power button event as a signal to shut down.

It worked perfectly :)

Thanks!

\__ Jason Munro
 \__ jason@stdbev.com
  \__ http://hastymail.sourceforge.net/


