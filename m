Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267271AbRGKK6l>; Wed, 11 Jul 2001 06:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267272AbRGKK6b>; Wed, 11 Jul 2001 06:58:31 -0400
Received: from hermes.netfonds.no ([195.204.10.138]:20109 "EHLO
	hermes.netfonds.no") by vger.kernel.org with ESMTP
	id <S267271AbRGKK6X>; Wed, 11 Jul 2001 06:58:23 -0400
To: Troy Benjegerdes <hozer@drgw.net>
Cc: Andreas Dilger <adilger@turbolinux.com>, linux-kernel@vger.kernel.org
Subject: Re: "Trying to free nonexistent swap-page" error message.
In-Reply-To: <la8zibpur5.fsf@glass.netfonds.no>
	<200106290902.f5T924Qv014328@webber.adilger.int>
	<20010710142813.O4148@altus.drgw.net>
In-Reply-To: <20010710142813.O4148@altus.drgw.net> (Troy Benjegerdes's message of "Tue, 10 Jul 2001 14:28:13 -0500")
From: Johan Simon Seland <johans@netfonds.no>
Date: 11 Jul 2001 12:58:12 +0200
Message-ID: <lawv5f3f7f.fsf@glass.netfonds.no>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Troy Benjegerdes <hozer@drgw.net> writes:

> My first guess would be hardware also, except in this case I've seen
> similiar things on three different dual processor G4 systems running 2.2,
> and they work fine with 2.4.

I have replaced all the memory with fresh 4x512MB REGISTRED ECC RAM,
and it has been running stable for 8 days now. I also replaced the
SCSI cables. 2.4 is not an option.

> Does Oracle for Linux us pthreads or the 'clone()' system call?

I am not really sure. How do I find out?

> Can you try running the included pthreads program on an 2.2.19 SMP system
> (but make it's idle, since if this is a genric 2.2 SMP bug it will
> probably crash the system)

Sorry, I am not going to risk bringing down the database with your
program. Its to critical for our business. (The database contains all
stock quotes for Oslo, Stockholm, Frankfurt, NYSE, AMEX and NASDAQ
stock exchanges and they are updated 24/7. I can only bring it down in
weekends, and only if it really important.)

However I have access to a few other dual boxen. (2x550, 2x350, 2x166
and a dual SparcStation 20). I can run your program on them with stock
2.2.19 SMP if you want me to.

-- 
Med vennlig hilsen 
Johan Seland
for Net Fonds ASA
