Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129112AbRCHPhx>; Thu, 8 Mar 2001 10:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129078AbRCHPhn>; Thu, 8 Mar 2001 10:37:43 -0500
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:3082 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129112AbRCHPhc>; Thu, 8 Mar 2001 10:37:32 -0500
Date: Thu, 08 Mar 2001 10:36:01 -0500
From: Chris Mason <mason@suse.com>
To: Mircea Damian <dmircea@kappa.ro>, linux-kernel@vger.kernel.org
Subject: Re: Kernel crash - reboot or hang
Message-ID: <477090000.984065761@tiny>
In-Reply-To: <20010308161723.A9138@linux.kappa.ro>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, March 08, 2001 04:17:23 PM +0200 Mircea Damian
<dmircea@kappa.ro> wrote:

> 
> Hello,
> 
> I NEED TO TRACE THIS!!!
> 
> I had two crashes with 2.4.2 and 2.4.2-pre2 on my local
> SMTP/POP3/SAMBA/WWW server (once under some load and the second one -
> with 2.4.2-pre2 - while it was almost idle).
> 
> The machine is an HP Netserver LHII without the standard raid card that
> comes with it (see bellow for dmesg output for a better description of
> hardware).
> 
> I do not see any corruption nor any messages in logs.
> 
> 
> Should I use kdb or just remote logging would do the job?

A serial console is probably your best bet.  You if your mail spool is on
reiserfs, you probably want to apply the dir fsync patch (included in
2.4.3pre and the latest ac stuff).

-chris


