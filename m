Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131419AbQKJVKg>; Fri, 10 Nov 2000 16:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131450AbQKJVK0>; Fri, 10 Nov 2000 16:10:26 -0500
Received: from ryouko.dgim.crc.ca ([142.92.39.75]:50609 "EHLO
	ryouko.dgim.crc.ca") by vger.kernel.org with ESMTP
	id <S131419AbQKJVKO>; Fri, 10 Nov 2000 16:10:14 -0500
Date: Fri, 10 Nov 2000 16:09:11 -0500 (EST)
From: "William F. Maton" <wmaton@ryouko.dgim.crc.ca>
Reply-To: wmaton@ryouko.dgim.crc.ca
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
cc: Andrea Arcangeli <andrea@suse.de>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [Fwd: sendmail fails to deliver mail with attachments in  /var/spool/mqueue]
In-Reply-To: <3A0C5A41.16EEAE78@timpanogas.org>
Message-ID: <Pine.GSO.3.96LJ1.1b7.1001110160719.514B-100000@ryouko.dgim.crc.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2000, Jeff V. Merkey wrote:

> Andrea Arcangeli wrote:
> > 
> > On Fri, Nov 10, 2000 at 03:07:46PM -0500, Richard B. Johnson wrote:
> > > It isn't a TCP/IP stack problem. It may be a memory problem. Every time
> > > sendmail spawns a child to send the file data, it crashes.  That's
> > > why the file never gets sent!
> > 
> > Sure that could be the case. You should be able to verify the kernel kills the
> > task with `dmesg`.
> > 
> > However Jeff said the problem happens over 400K and a 500K attachment shouldn't
> > really run any machine out of memory, so maybe this wasn't his same problem?
> 
> I think it is.  So it looks like sendmail is bombing when it attempts to
> send large files. 

Not to use the 'S-word', but we're receiving/sending biggish attachments
(7MB-9MB) under Solaris 2.6.  Could sendmail be triggering a linux bug, or
could something specific to linux be triggering a sendmail bug?

> Jeff 

wfms

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
