Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261288AbSJCVOs>; Thu, 3 Oct 2002 17:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261338AbSJCVOs>; Thu, 3 Oct 2002 17:14:48 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:45553 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S261288AbSJCVOq>;
	Thu, 3 Oct 2002 17:14:46 -0400
Message-ID: <3D9CB470.8BCA89F7@mvista.com>
Date: Thu, 03 Oct 2002 14:19:44 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
CC: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Dual PPro timer stopping problem
References: <14632.1033653828@warthog.cambridge.redhat.com> <3D9C7E7E.7B2BFB52@mvista.com> <20021003164641.F16875@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
> 
> On Thu, Oct 03, 2002 at 10:29:34AM -0700, george anzinger wrote:
> > The keyboard is, or at least depends on polling which is
> > controled by a timer, thus, no timer, => no keyboard.
> 
> Eh?  Sure, by a timer internal to the keyboard itself.  At least x86
> hardware has an interrupt wired to its keyboard controller that is used
> to signal when a keystroke is available, and if you look into the driver,
> you'd see that no timers are used at all.
> 
Hm?  I must have been seeing double ;)  Been doing that a
lot lately :(
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
