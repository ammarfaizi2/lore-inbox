Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284244AbRLTLhR>; Thu, 20 Dec 2001 06:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284246AbRLTLhI>; Thu, 20 Dec 2001 06:37:08 -0500
Received: from jubjub.wizard.com ([209.170.216.9]:63749 "EHLO
	jubjub.wizard.com") by vger.kernel.org with ESMTP
	id <S284244AbRLTLg6>; Thu, 20 Dec 2001 06:36:58 -0500
Date: Thu, 20 Dec 2001 03:36:54 -0800
From: A Guy Called Tyketto <tyketto@wizard.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 'eject' process stuck in "D" state
Message-ID: <20011220113654.GA1271@wizard.com>
In-Reply-To: <20011220111249.GA15692@wizard.com> <20011220122325.A710@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011220122325.A710@suse.de>
User-Agent: Mutt/1.3.23.2i
X-Operating-System: Linux/2.5.1-dj3 (i686)
X-uptime: 3:32am  up 15 min,  2 users,  load average: 0.00, 0.03, 0.01
X-RSA-KeyID: 0xE9DF4D85
X-DSA-KeyID: 0xE319F0BF
X-PGP-Keys: see http://www.omnilinx.net/~tyketto/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2001 at 12:23:25PM +0100, Jens Axboe wrote:
> On Thu, Dec 20 2001, A Guy Called Tyketto wrote:
> > 
> >         Hate to be an old bugger and bring this up again, but I just had this 
> > old problem show up again, with 2.5.1-dj3. The scoop:
> 
> Were you using sr or ide-cd when this happened? There seems to be stuff
> missing from the kernel messages you included, could you please check
> dmesg for all of it.
> 
> Don't worry, it's no shocker if eject isn't working :-)

        Sorry.. forgot to include that as well. Here's my lsmod output 
revelant to the problem, at the time of it happening:

ide-cd                 26816   0 (autoclean)
sr_mod                 13524   0 (autoclean) (unused)
cdrom                  29344   0 (autoclean) [ide-cd sr_mod]
scsi_mod               71544   1 (autoclean) [sr_mod]

        I manually tried the CD drive's eject button, and of course, it didn't 
work. The kernel hadn't freed up the device, so there's no reason why it 
wouldn't have worked.

                                                        BL.
-- 
Brad Littlejohn                         | Email:        tyketto@wizard.com
Unix Systems Administrator,             |           tyketto@ozemail.com.au
Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
  PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF

