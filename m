Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129771AbRBYVQk>; Sun, 25 Feb 2001 16:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129769AbRBYVQb>; Sun, 25 Feb 2001 16:16:31 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:35085 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129760AbRBYVQT>;
	Sun, 25 Feb 2001 16:16:19 -0500
Date: Sun, 25 Feb 2001 22:16:02 +0100
From: Jens Axboe <axboe@suse.de>
To: Mircea Ciocan <mirceac@interplus.ro>
Cc: Siddharth Kashyap <kernel_i386@yahoo.com>,
        lk <linux-kernel@vger.kernel.org>
Subject: Re: Incorrect CD Drive speed
Message-ID: <20010225221602.N7830@suse.de>
In-Reply-To: <20010225182123.66799.qmail@web12808.mail.yahoo.com> <3A995873.4939ED4A@interplus.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A995873.4939ED4A@interplus.ro>; from mirceac@interplus.ro on Sun, Feb 25, 2001 at 09:09:39PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 25 2001, Mircea Ciocan wrote:
> 	Simple, our friends at No-name OEM Corporation ;) named that drive
> "CDROM DRIVE 52X" in his ID string, a perfect OEM name that does not
> involves any brand and looks good in windoze where the l/user see it in
> system configuration as above.
> 	The hard reality is next, meaning the Linux driver determined "by
> specific means" :) that the drive is at most "48X CD-ROM DRIVE w/128kb
> buffer", THAT windozians will NOT see it.

None of the two are the hard reality, the latter is just what
the drive reports in the mode sense page while (as you correctly
identified) the former is the info from the inquiry command. Why
these don't match up is a question best asked at the manufacturerer :)

-- 
Jens Axboe

