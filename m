Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135484AbREABEy>; Mon, 30 Apr 2001 21:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135850AbREABEo>; Mon, 30 Apr 2001 21:04:44 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:6918 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S135484AbREABE3>; Mon, 30 Apr 2001 21:04:29 -0400
Date: Mon, 30 Apr 2001 21:03:47 -0400
From: Chris Mason <mason@suse.com>
To: Daniel Elstner <daniel.elstner@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: reiserfs+lndir problem [was: 2.4.4 SMP: spurious EOVERFLOW
 "Value too large for defined data type"]
Message-ID: <1026200000.988679027@tiny>
In-Reply-To: <20010430225557.3f28d1b0.daniel@master.daniel.homenet>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday, April 30, 2001 10:55:57 PM +0200 Daniel Elstner
<daniel.elstner@gmx.net> wrote:

> Hi all,
> 
> unfortunately I have to correct me again.
> The problem seems unrelated to the kernel version or SMP/UP
> (though only 2.4.[34] tried yet).
> 
> Apparently it's a reiserfs/symlink problem.
> I tried doing the lndir on an ext2 partition, sources still
> on reiserfs. And it worked just fine!

Neat, thanks for the extra details.  Does that mean you can consistently
repeat on reiserfs now?  What happens when you do the lndir on reiserfs and
diff the directories?

Any useful messages in /var/log/messages?

