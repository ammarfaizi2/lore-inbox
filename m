Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282042AbRLATGV>; Sat, 1 Dec 2001 14:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282067AbRLATGL>; Sat, 1 Dec 2001 14:06:11 -0500
Received: from smtp.alacritech.com ([209.10.208.82]:10 "EHLO
	smtp.alacritech.com") by vger.kernel.org with ESMTP
	id <S282042AbRLATFz>; Sat, 1 Dec 2001 14:05:55 -0500
Message-ID: <3C0928D5.7E876339@alacritech.com>
Date: Sat, 01 Dec 2001 11:00:37 -0800
From: "Matt D. Robinson" <yakker@alacritech.com>
Organization: Alacritech, Inc.
X-Mailer: Mozilla 4.78 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Brian Gerst <bgerst@didntduck.org>
CC: Davide Libenzi <davidel@xmailserver.org>,
        Simon Turvey <turveysp@ntlworld.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Generating a function call trace
In-Reply-To: <Pine.LNX.4.40.0111300900050.1600-100000@blue1.dev.mcafeelabs.com> <3C07CDF9.F1069C71@didntduck.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try using 'lcrash', part of the LKCD project:

	http://lkcd.sourceforge.net/

I'm not sure what you mean by arbitrarily (meaning, it could be
at a snapshot point in time, or it could be while it is running,
etc.)  E-mail me if you have further questions, I'll try to help.

--Matt

Brian Gerst wrote:
> 
> Davide Libenzi wrote:
> >
> > On Fri, 30 Nov 2001, Simon Turvey wrote:
> >
> > > Is it possible to arbitrarily generate (in a module say) a function call
> > > trace?
> >
> > gcc has builtin macros to trace back or ( on x86 ) you can simply chain
> > through %esp/%ebp
> 
> That only works if you compile with frame pointers, which the kernel
> turns off for performance reasons (due to register pressure on the x86).
> 
> --
> 
>                                 Brian Gerst
