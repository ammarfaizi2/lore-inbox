Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264940AbSKEV7A>; Tue, 5 Nov 2002 16:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265028AbSKEV7A>; Tue, 5 Nov 2002 16:59:00 -0500
Received: from nameservices.net ([208.234.25.16]:41534 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S264940AbSKEV67>;
	Tue, 5 Nov 2002 16:58:59 -0500
Message-ID: <3DC8418D.A0B8E752@opersys.com>
Date: Tue, 05 Nov 2002 17:09:17 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: ps performance sucks (was Re: dcache_rcu [performance results])
References: <20021030161912.E2613@in.ibm.com> <20021031162330.B12797@in.ibm.com> <3DC32C03.C3910128@digeo.com> <20021102144306.A6736@dikhow> <1025970000.1036430954@flay> <20021105000010.GA21914@pegasys.ws> <1118170000.1036458859@flay>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm not sure why people are trying to make pigs fly, but if you
really need in-depth information regarding a process or a set
of processes, you should be looking at something that's been
designed from the ground up to actually carry this weight, which
is exactly what LTT is about. Using this approach, all the
accounting gets to be done in user-space. It's like using
"top -q" without the actual disadvantage of killing your system.

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
