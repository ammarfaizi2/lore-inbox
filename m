Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268295AbTCFU1K>; Thu, 6 Mar 2003 15:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268332AbTCFU1K>; Thu, 6 Mar 2003 15:27:10 -0500
Received: from air-2.osdl.org ([65.172.181.6]:50606 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S268295AbTCFU1J>;
	Thu, 6 Mar 2003 15:27:09 -0500
Date: Thu, 6 Mar 2003 12:36:01 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: aia21@cantab.net, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [Linux-NTFS-Dev] ntfs OOPS (2.5.63)
Message-Id: <20030306123601.0fdcc6ad.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.30.0303062101570.31029-100000@divine.city.tvnet.hu>
References: <Pine.LNX.4.30.0303062035390.31029-100000@divine.city.tvnet.hu>
	<Pine.LNX.4.30.0303062101570.31029-100000@divine.city.tvnet.hu>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Mar 2003 21:15:35 +0100 (MET) Szakacsits Szabolcs <szaka@sienet.hu> wrote:

| 
| On Thu, 6 Mar 2003, Szakacsits Szabolcs wrote:
| > On Thu, 6 Mar 2003, Randy.Dunlap wrote:
| > > I must have missed something here.  What other 2 oopses are you
| > > referring to?
| >
| > Quoting from your report:
| >
| > ==> Mar  1 13:35:44 midway kernel: Oops: 0002
| >
| > This means oops counter is 2. So there were two oopses before with
| > counter value 0 and 1.
| 
| I just checked, this is not true (I could dig up the false source
| of information if interested). It's error_code: no page found,
| kernel-mode write fault. Sorry for the confusion :(
| 
| > > As for closing bug reports because they are not reproducible...
| >
| > No. Not because it's not reproducible however because it's untrustable
| > and bogus. Unless as I mentioned before ... please see above. Thanks!
| 
| So this is also invalid ... Could you please send the 'objdump -S
| fs/ntfs/inode.o' output? The __ntfs_init_inode part would be enough
| also.

I'm glad that this little confusion is cleared up.
I was about to correct it, but you beat me to it.
However, such an oops counter could be useful...

--
~Randy
