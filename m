Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280805AbRLLPWm>; Wed, 12 Dec 2001 10:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280814AbRLLPWc>; Wed, 12 Dec 2001 10:22:32 -0500
Received: from crunchy.sound.net ([205.242.194.25]:37827 "HELO
	crunchy.sound.net") by vger.kernel.org with SMTP id <S280805AbRLLPWS>;
	Wed, 12 Dec 2001 10:22:18 -0500
Message-ID: <3C177767.8132794F@sound.net>
Date: Wed, 12 Dec 2001 09:27:35 -0600
From: A Duston <hald@sound.net>
X-Mailer: Mozilla 4.77 [en] (Win98; U)
X-Accept-Language: en,el
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: bio and "old" block drivers
In-Reply-To: <Pine.GSO.4.10.10112111539180.5913-100000@sound.net> <20011212101957.GE7562@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> On Tue, Dec 11 2001, Hal Duston wrote:
> > I'm looking at the bio changes for ps2esdi.  The driver
> > appears to no longer work compiled when into the kernel.
> > The ps2esdi_init call has been removed from
> > ll_rw_blk.c:blk_dev_init.  Where is the new/correct place
> > to call this from?  This appears to be the same way with
> > many of the other "old" block drivers as well.
> 
> Just use module_init to make this happen automagically.

Sorry, I am not understanding you here.  Could you spell it 
out please?  My root filesystem is on the ps2esdi disk, do 
I need to set up an initrd, and load the ps2esdi driver as 
a module?  Or do you mean that I should change things to 
have module_init call it even when it isn't built as a 
module?  Or something else?

Thanks,
Hal Duston
hald@sound.net
