Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281188AbRKHAgp>; Wed, 7 Nov 2001 19:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281185AbRKHAge>; Wed, 7 Nov 2001 19:36:34 -0500
Received: from fluent1.pyramid.net ([206.100.220.212]:38703 "EHLO
	fluent1.pyramid.net") by vger.kernel.org with ESMTP
	id <S281188AbRKHAgT>; Wed, 7 Nov 2001 19:36:19 -0500
Message-Id: <4.3.2.7.2.20011107163407.00dd97c0@10.1.1.42>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Wed, 07 Nov 2001 16:35:51 -0800
To: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
From: Stephen Satchell <satch@concentric.net>
Subject: Re: Yet another design for /proc. Or actually /kernel.
In-Reply-To: <9sc79g$413$1@cesium.transmeta.com>
In-Reply-To: <slrn9uj1nf.5lj.spamtrap@dexter.hensema.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:58 PM 11/7/01 -0800, H. Peter Anvin wrote:
>Actually, /proc/mounts is currently broken, and is an excellent
>example of why the above statement simply isn't true unless you apply
>another level of indirection: try mounting something on a directory
>the name of which contains whitespace in any form (remember, depending
>on your setup this may be doable by an unprivileged user...)

Good man.

Now you know why I insisted that ALL STRINGS have a standard escape system 
in my less-than-strawman proposal.

You'll find other places in /proc where white space is not necessarily a 
delimiter.  (Too lazy to go find them right now, however.)

Satch

