Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286529AbRLUBy6>; Thu, 20 Dec 2001 20:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286527AbRLUByt>; Thu, 20 Dec 2001 20:54:49 -0500
Received: from jubjub.wizard.com ([209.170.216.9]:29957 "EHLO
	jubjub.wizard.com") by vger.kernel.org with ESMTP
	id <S286523AbRLUByd>; Thu, 20 Dec 2001 20:54:33 -0500
Date: Thu, 20 Dec 2001 17:54:30 -0800
From: A Guy Called Tyketto <tyketto@wizard.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 'eject' process stuck in "D" state
Message-ID: <20011221015430.GA1498@wizard.com>
In-Reply-To: <20011220111249.GA15692@wizard.com> <20011220122325.A710@suse.de> <20011220113654.GA1271@wizard.com> <20011220123904.B710@suse.de> <20011220120750.GA1429@wizard.com> <20011220131116.C710@suse.de> <20011220122414.GA507@wizard.com> <20011220132805.D710@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011220132805.D710@suse.de>
User-Agent: Mutt/1.3.23.2i
X-Operating-System: Linux/2.5.1-dj4 (i686)
X-uptime: 5:52pm  up 15 min,  2 users,  load average: 0.00, 0.01, 0.02
X-RSA-KeyID: 0xE9DF4D85
X-DSA-KeyID: 0xE319F0BF
X-PGP-Keys: see http://www.omnilinx.net/~tyketto/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2001 at 01:28:05PM +0100, Jens Axboe wrote:
> On Thu, Dec 20 2001, A Guy Called Tyketto wrote:
> >         Just getting to that. as I brought down the box, I got some errors on 
> > /dev/tty1, which are the same from dmesg. 'ere ya go.
> 
> Ah, please try this patch.
> 
> -- 
> Jens Axboe
> 

        Thanks. just gave it a try with -dj4, and it works fine. The eject 
button in xplaycd doesn't work anymore, but that's something the coder can 
look at. /usr/bin/eject works fine as well.

        When able, please apply this to the main tree, if it's not there 
already.

                                                        BL.
-- 
Brad Littlejohn                         | Email:        tyketto@wizard.com
Unix Systems Administrator,             |           tyketto@ozemail.com.au
Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
  PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF

