Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265759AbRF2IWu>; Fri, 29 Jun 2001 04:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265771AbRF2IWk>; Fri, 29 Jun 2001 04:22:40 -0400
Received: from adsl-63-198-73-118.dsl.lsan03.pacbell.net ([63.198.73.118]:18950
	"HELO turing.xman.org") by vger.kernel.org with SMTP
	id <S265759AbRF2IW3>; Fri, 29 Jun 2001 04:22:29 -0400
Message-Id: <5.1.0.14.0.20010629012013.02a29ac0@imap.xman.org>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 29 Jun 2001 01:22:30 -0700
To: John Fremlin <vii@users.sourceforge.net>, Dan Kegel <dank@kegel.com>
From: Christopher Smith <x@xman.org>
Subject: Re: A signal fairy tale
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <m23d8kiwx0.fsf@boreas.yi.org.>
In-Reply-To: <3B38860D.8E07353D@kegel.com>
 <3B38860D.8E07353D@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:58 PM 6/28/2001 +0100, John Fremlin wrote:
>         Dan Kegel <dank@kegel.com> writes:
> >        A signal number cannot be opened more than once concurrently;
> >        sigopen() thus provides a way to avoid signal usage clashes
> >        in large programs.
>Signals are a pretty dopey API anyway - so instead of trying to patch
>them up, why not think of something better for AIO?

You assume that this issue only comes up when you're doing AIO. If we do 
something that makes signals work better, we can have a much broader impact 
that just AIO. If nothing else, the signal usage clashing issue has nothing 
to do with AIO.

--Chris

