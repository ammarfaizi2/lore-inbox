Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265670AbTAXVFD>; Fri, 24 Jan 2003 16:05:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265681AbTAXVFD>; Fri, 24 Jan 2003 16:05:03 -0500
Received: from [209.195.52.120] ([209.195.52.120]:37303 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id <S265670AbTAXVE4>; Fri, 24 Jan 2003 16:04:56 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Kevin Lawton <kevinlawton2001@yahoo.com>
Cc: Derek Fawcus <dfawcus@cisco.com>, Valdis.Kletnieks@vt.edu,
       Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Date: Fri, 24 Jan 2003 13:00:46 -0800 (PST)
Subject: Re: Simple patches for Linux as a guest OS in a plex86 VM (please
 consider)
In-Reply-To: <20030124205658.15127.qmail@web80304.mail.yahoo.com>
Message-ID: <Pine.LNX.4.44.0301241256200.10187-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

it sounds like you are saying that with the plex86 you have two ways to
load a client OS.

1. 'normal', full isolation of VMs no modification of the client OS
needed.

2. 'nice VM'. modification of the client OS required, but with the
exception of the kernel level commands being eliminated in the
modification full VM isolation is still provided. Much better performance
then case #1

if you load a client OS and tell the system that it's a #2 when it's
really a #1 then you don't have valid isolation, but that's a sysadmin
error that you will allow to happen in order to make #2 possible.

is this correct

David Lang

On Fri, 24 Jan 2003, Kevin Lawton wrote:

> Date: Fri, 24 Jan 2003 12:56:58 -0800 (PST)
> From: Kevin Lawton <kevinlawton2001@yahoo.com>
> To: Derek Fawcus <dfawcus@cisco.com>
> Cc: Valdis.Kletnieks@vt.edu, Pavel Machek <pavel@ucw.cz>,
>      linux-kernel@vger.kernel.org
> Subject: Re: Simple patches for Linux as a guest OS in a plex86 VM
>     (please consider)
>
>
> --- Derek Fawcus <dfawcus@cisco.com> wrote:
> > It doesn't belong on the LK list.
> >
> > Well actually I find it quite interesting...
> >
> > One thing that seems to have been alluded to but not explicity stated
> > is just where is this patch going, and what affect will happen when
> > running a non 'VM friendly' OS under the 'new plex86'.
>
> The effect of a non VM'able guest would be it would go into the weeds.
> And that effect is irrelevant to the LK list, be you interested or
> not.  Because that involves no particular issues of Linux as
> a host nor guest, not the simple patches I submitted.  Off-list, please.
>
> -Kevin
>
> __________________________________________________
> Do you Yahoo!?
> New DSL Internet Access from SBC & Yahoo!
> http://sbc.yahoo.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
