Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276906AbRJHOud>; Mon, 8 Oct 2001 10:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276911AbRJHOuX>; Mon, 8 Oct 2001 10:50:23 -0400
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:53003 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S276906AbRJHOuI>; Mon, 8 Oct 2001 10:50:08 -0400
X-Apparently-From: <quintaq@yahoo.co.uk>
Date: Mon, 8 Oct 2001 15:50:17 +0100
From: quintaq@yahoo.co.uk
To: linux-kernel@vger.kernel.org
Subject: Problem creating filesystems (and othe operations) under 2.4.10
Reply-To: quintaq@yahoo.co.uk
X-Mailer: Sylpheed version 0.6.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20011008145018Z276906-760+22140@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am not subscribed to this list, so I would appreciate it if any replies
could be cc'd to me.

Is the following problem I have encountered symptomatic of a bug in 2.4.10?

I have just installed a Maxtor 30GB drive as /dev/hdc in my SuSE 7.0 system
which has a vanilla 2.4.10 kernel.  I found that I could write the
partition table and create a small ext2 partition for /boot plus 768MB of
swap.  Creation of the main ext2 filesystem on /hdc7 failed (before the
inode tables even began to be written), with "file size limit exceeded".
The same problem recurred every time I tried - and I did try various
combinations of partition size.  I see the same error message when trying
to change partition table flags.  The problem is identical using fdisk,
cfdisk and parted.  I have no file limits set in ulimit and I do not think
that this is the problem. 

I eventually put the same drive as /dev/hdc in another box running a stock
SuSE 2.2.16 kernel and creation of the filesystems completed without any
problem.  I have also verified this by booting this box using SuSE's 2.2.16
rescue kernel.

Any ideas?

Regards,

Geoff

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

