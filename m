Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262966AbTDFNAB (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 09:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262967AbTDFNAB (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 09:00:01 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45492 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262966AbTDFNAA (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 09:00:00 -0400
Date: Sun, 6 Apr 2003 14:11:32 +0100
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: Michael Buesch <freesoftwaredeveloper@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Serial port over TCP/IP
Message-ID: <20030406131132.GJ639@gallifrey>
References: <200304061447.46393.freesoftwaredeveloper@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304061447.46393.freesoftwaredeveloper@web.de>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.5.66 (i686)
X-Uptime: 14:08:43 up 1 day,  1:32,  1 user,  load average: 0.06, 0.11, 0.17
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Michael Buesch (freesoftwaredeveloper@web.de) wrote:
> Hi.
> 
> Is it possible to make a char-dev (a serial device ttyS0)
> available via TCP/IP on a network like it is possible
> for block-devices like a harddisk via nbd?
> Is kernel-support for this present?
> If not, is it technically possible to develop such a driver?

I keep thinking that it would be nice to have a mechanism for user space
char devices; it would have to have a mechanism to pass all the ioctls
to the process that dealt with it.

(The particular cases which sparked this idea for me were to do user
space SCSI tape drivers to do raid tape and the like, and for emulation
of touch screens or mice on systems that only had the other.).

Dave
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
