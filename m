Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270802AbRHNUSn>; Tue, 14 Aug 2001 16:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270784AbRHNUSd>; Tue, 14 Aug 2001 16:18:33 -0400
Received: from staff.cs.usyd.edu.au ([129.78.8.1]:9141 "helo
	staff.cs.usyd.edu.au") by vger.kernel.org with SMTP
	id <S270798AbRHNUSY>; Tue, 14 Aug 2001 16:18:24 -0400
Date: Wed, 15 Aug 2001 02:06:07 +1100
From: bruce@cs.usyd.edu.au (Bruce Janson)
To: linux-kernel@vger.kernel.org
Subject: Re: ptrace(), fork(), sleep(), exit(), SIGCHLD
In-Reply-To: <20010813093116Z270036-761+611@vger.kernel.org> <20010814092849.E13892@pc8.lineo.fr>
Message-Id: <20010814201825Z270798-760+1687@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010814092849.E13892@pc8.lineo.fr>,
christophe =?iso-8859-1?Q?barb=E9?=  <christophe.barbe@lineo.fr> wrote:
..
>Le lun, 13 aoû 2001 10:29:32, Bruce Janson a écrit :
..
>>     The following program behaves incorrectly when traced:
..
>Have you receive off-line answers?
..

No, though I did receive an offline reply from someone who appeared
to have misunderstood the post.  In case it wasn't clear, the problem
is that the above program behaves differently when traced to how it
behaves when not traced.  (I do realise that in general, under newer
Unices, when not ignored, a SIGCHLD signal may accompany the death of
a child.)

>I guess that it's certainly more a strace issue and that it's perhaps
..

It's not clear to me whether it is a kernel, glibc or strace bug, but
it does appear to be a bug.
