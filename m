Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281967AbRKZR4L>; Mon, 26 Nov 2001 12:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281964AbRKZR4C>; Mon, 26 Nov 2001 12:56:02 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:5639 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S281967AbRKZRzs>; Mon, 26 Nov 2001 12:55:48 -0500
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.15-pre1:  "bogus" message with reiserfs root and other weirdness
In-Reply-To: <Pine.LNX.3.96.1011126114550.26538A-100000@gatekeeper.tmr.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 27 Nov 2001 02:54:54 +0900
In-Reply-To: <Pine.LNX.3.96.1011126114550.26538A-100000@gatekeeper.tmr.com>
Message-ID: <87elmlmn81.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen <davidsen@tmr.com> writes:

> On 27 Nov 2001, OGAWA Hirofumi wrote:
> 
> > davidsen@tmr.com (bill davidsen) writes:
> 
> Actually the original poster used "magic" and I didn't quibble, but I
> believe you're right. I just noted that it is better to check to see if
> the filesystem is FAT before reporting the error message. Obviously this
> can be done, since you don't get the message with FAT as a module, I just
> haven't looked to see if the check is in the module or the kernel before
> even loading the FAT module.

Yes. You can't use the module before you mounted the root filesystem.
This is a reason for not seeing an error message.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
