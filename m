Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288960AbSANTzF>; Mon, 14 Jan 2002 14:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288952AbSANTyC>; Mon, 14 Jan 2002 14:54:02 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:11764 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S288982AbSANTxU>; Mon, 14 Jan 2002 14:53:20 -0500
Message-ID: <3C4336FC.DE812038@mvista.com>
Date: Mon, 14 Jan 2002 11:52:28 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Lowery <Robert.Lowery@colorbus.com.au>
CC: linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <370747DEFD89D2119AFD00C0F017E66156A8AE@cbus613-server4.colorbus.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Lowery wrote:
> 
> >I question this because it is too risky to apply. There is no way any
> >distribution or production system could ever consider applying the
> >preempt kernel and ship it in its next kernel update 2.4. You never know
> >if a driver will deadlock because it is doing a test and set bit busy
> >loop by hand instead of using spin_lock and you cannot audit all the
> >device drivers out there.
> 
> Quick question from a kernel newbie.
> 
> Could this audit be partially automated by the Stanford Checker? or would
> there
> be too many false positives from other similar looping code?
> 
> -Robert
Sounds like a REALLY good thing (tm) to me.  How do we get them
interested?
-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
