Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280685AbRKBNSL>; Fri, 2 Nov 2001 08:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280686AbRKBNSC>; Fri, 2 Nov 2001 08:18:02 -0500
Received: from mail.internet-factory.de ([195.122.142.5]:41189 "EHLO
	mail.internet-factory.de") by vger.kernel.org with ESMTP
	id <S280685AbRKBNRx>; Fri, 2 Nov 2001 08:17:53 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Holger Lubitz <h.lubitz@internet-factory.de>
Newsgroups: lists.linux.kernel
Subject: Re: aic7xxx 6.2.1 unstable?
Date: Fri, 02 Nov 2001 14:17:49 +0100
Organization: Internet Factory AG
Message-ID: <3BE29CFD.52A96F44@internet-factory.de>
In-Reply-To: <200111011940.fA1JeVY35797@aslan.scsiguy.com>
NNTP-Posting-Host: bastille.internet-factory.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Trace: darkstar.internet-factory.de 1004707072 3174 195.122.142.158 (2 Nov 2001 13:17:52 GMT)
X-Complaints-To: usenet@internet-factory.de
NNTP-Posting-Date: 2 Nov 2001 13:17:52 GMT
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13-ac5 i686)
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Justin T. Gibbs" proclaimed:

> Care to share the console messages?

Sorry, but the machine was locked solid and I did not take the time to
write them down manually. I was hoping for something in the system
logfile, but all I found there were several tons of these:

Nov  1 04:52:31 darkstar kernel: Device 08:11 not ready.
Nov  1 04:52:31 darkstar kernel:  I/O error: dev 08:11, sector 4735240

(not really helpful since this comes from a higher layer)

As far as I remember, the console messages were some scsi timeouts and
"trying to abort command", which the host adapter believed successful,
but the sequence repeated. I think that the second drive (hosting
/var/spool) got confused, the system continued running, until the first
drive (hosting the rest of the partitions) got confused, too (approx.
five hours later) and then the system hung. Sorry again that I cannot
provide more detail, which was why I did not want to formally report a
bug, just pass a word of warning, partly in the hope that someone else
was experiencing similar things and could fill in some detail.

Holger
