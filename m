Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317481AbSFMGNu>; Thu, 13 Jun 2002 02:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317480AbSFMGNt>; Thu, 13 Jun 2002 02:13:49 -0400
Received: from rj.SGI.COM ([192.82.208.96]:32960 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S317477AbSFMGNr>;
	Thu, 13 Jun 2002 02:13:47 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Federico Sevilla III <jijo@free.net.ph>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        BugTraq Mailing List <bugtraq@securityfocus.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: rlimits and non overcommit (was: Very large font size ...) 
In-Reply-To: Your message of "Thu, 13 Jun 2002 13:57:33 +0800."
             <Pine.LNX.4.44.0206131352510.3677-100000@kalabaw> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 13 Jun 2002 16:11:25 +1000
Message-ID: <2660.1023948685@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jun 2002 13:57:33 +0800 (PHT), 
Federico Sevilla III <jijo@free.net.ph> wrote:
>On Thu, 13 Jun 2002 at 06:39, Alan Cox wrote:
>> > check to prevent such large sizes from crashing X and/or the X Font
>> > Server, I'm alarmed by (1) the way the X font server allows itself to
>> > be crashed like this, and (2) the way the entire Linux kernel seems to
>> > have been unable to handle the situation. While having a central
>> > company or
>>
>> So turn on the features to conrol it. Set rlimits on the xfs server and
>> enable non overcommit (-ac kernel)
>
>I am using SGI's XFS, and I think they follow Marcelo's kernels for the

SGI's XFS != xfs server.  SGI XFS == journalling filesystem.
xfs server == font server for the X windowing system.

