Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131262AbRCHDWv>; Wed, 7 Mar 2001 22:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131264AbRCHDWl>; Wed, 7 Mar 2001 22:22:41 -0500
Received: from shell.ca.us.webchat.org ([216.152.64.152]:1971 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S131262AbRCHDWX>; Wed, 7 Mar 2001 22:22:23 -0500
Message-ID: <012301c0a77f$878995c0$7c4cf9d1@geeksparadise.com>
Reply-To: "David Schwartz" <davids@webmaster.com>
From: "David Schwartz" <davids@webmaster.com>
To: "Helge Hafting" <helgehaf@idb.hist.no>,
        "Gregory Maxwell" <greg@linuxpower.cx>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <20010306172843.D1283@hpspss3g.spain.hp.com> <20010306115822.A2244@xi.linuxpower.cx> <3AA5F8E1.AC570516@idb.hist.no>
Subject: Re: Process vs. Threads
Date: Wed, 7 Mar 2001 19:09:35 -0800
Organization: WebMaster, Incorporated
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> Gregory Maxwell wrote:
>
> >
> > There are no threads in Linux.
> > All tasks are processes.
> > Processes can share any or none of a vast set of resources.
> >
> Is there a way a user program can find out what resources
> are shared among which processes?
>
> That would allow enhancing ps, top, etc to
> report memory usage correctly.

    In fact, 'top' does report memory usage correctly. What 'top' should do,
however, is (by default) suppress the display of additional processes that
share a vm, showing only the 'highest parent' in the tree of processes that
share a vm.

    DS



