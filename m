Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263083AbSJGPK5>; Mon, 7 Oct 2002 11:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263084AbSJGPK4>; Mon, 7 Oct 2002 11:10:56 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:38394 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S263083AbSJGPKy> convert rfc822-to-8bit;
	Mon, 7 Oct 2002 11:10:54 -0400
Message-ID: <3DA1A532.9BF70424@mvista.com>
Date: Mon, 07 Oct 2002 08:16:02 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Eduardo =?iso-8859-1?Q?P=E9rez?= <100018135@alumnos.uc3m.es>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] namespace clean
References: <a6cf5427338512cb0ae6b015e16b896a@alumnos.uc3m.es>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eduardo Pérez wrote:
> 
> Currently the Linux kernel has a cryptic api namespace that confuses
> many people when trying to code for the Linux kernel. People can't know
> by direct examination of a symbol to what package belongs. Also symbols
> can't be easily sorted by package.
> 
> I'm suggesting to use a cleaner namespace like
> package_object_method and package_function
> If this is accepted, symbols from new code should follow this
> naming, and current symbols should start the transition to this cleaner
> namespace.
> 
> If anybody like me think that this would help people to code for the
> Linux kernel it would be a good idea to start this transition to a
> cleaner namespace.
> 
> Most drivers and new core kernel api have a very clean namespace but
> some old api don't.
> 
> What are your thoughts about this ?

Then if it is a static symbol, one could use anything?  I.e.
static symbols would not follow the rule, right?
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
