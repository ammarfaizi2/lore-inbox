Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261574AbSKKXEW>; Mon, 11 Nov 2002 18:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261581AbSKKXEW>; Mon, 11 Nov 2002 18:04:22 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:2688 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S261574AbSKKXEV>; Mon, 11 Nov 2002 18:04:21 -0500
Date: Tue, 12 Nov 2002 10:10:53 +1100
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.5.47 / unusual ext3 fs errors
Message-ID: <20021111231053.GA1518@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Under 2.5.x I seem to be getting a lot of fs errors on fsck, mainly
dealing with bad inode counts in groups. Just now though, I had /var
remounted read-only due to the following:

t_transaction: Journal has aborted
EXT3-fs error (device ide0(3,9)) in start_transaction: Journal has aborted
EXT3-fs error (device ide0(3,9)) in start_transaction: Journal has aborted
EXT3-fs error (device ide0(3,9)) in start_transaction: Journal has aborted
...
EXT3-fs error (device ide0(3,9)) in start_transaction: Journal has aborted
EXT3-fs error (device ide0(3,9)) in start_transaction: Journal has aborted
EXT3-fs error (device ide0(3,9)) in start_transaction: Journal has aborted

And again, on reboot into single user mode and a full fsck bad inode
count errors were present. There were no errors detected whilst testing
the disk with -c.

Under 2.4.x my filesystems never showed errors.

I'd provide more info but this is all that I have. If you need more then
you'll need to tell me what to do to get it. :)

Thanks.

-- 
        All people are equal,
        But some are more equal then others.
            - George W. Bush Jr, President of the United States
              September 21, 2002 (Abridged version of security speech)
