Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313022AbSDORmL>; Mon, 15 Apr 2002 13:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313027AbSDORmK>; Mon, 15 Apr 2002 13:42:10 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:58123 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S313022AbSDORmK>;
	Mon, 15 Apr 2002 13:42:10 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Jens Axboe <axboe@suse.de>
Date: Mon, 15 Apr 2002 19:41:57 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] IDE TCQ #4
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <274A9BD5C76@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Apr 02 at 18:44, Jens Axboe wrote:

> > You can run a IDENTIFY_DEVICE from user space with the task ioctls and
> > look at word 83 -- bit 1 and 14 must be set for TCQ to be supported. If
> > you give me the model identifier from the IBM drive, I can tell you if
> > it has tcq or not...
> > 
> > I'll write a small util to detect this tomorrow and send it to you + the
> > list.
> 
> Duh, you can of course just look at /proc/ide/ideX/hdY/identify and
> parse that. The info above is still valid for that, of course :-)

If I parsed file correctly (it is 83 decimal word, yes?), WD's
WDC WD1200JB-00CRA0 supports TCQ too. I'm still deciding which of
TCQ #X and IDE #YY patches should be aplied to 2.5.8 to get optimal
results (and I have to disconnect slaves...).
                                                Best regards,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
