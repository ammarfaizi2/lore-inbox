Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269133AbTCDEAd>; Mon, 3 Mar 2003 23:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269143AbTCDEAd>; Mon, 3 Mar 2003 23:00:33 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:61424 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id <S269133AbTCDEAc>; Mon, 3 Mar 2003 23:00:32 -0500
Date: Mon, 3 Mar 2003 21:09:56 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Beneath <ishikodzume@beneath.plus.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: EXT3: linux-2.4.21-pre5
Message-ID: <20030303210956.M1373@schatzie.adilger.int>
Mail-Followup-To: Beneath <ishikodzume@beneath.plus.com>,
	linux-kernel@vger.kernel.org
References: <20030304024714.647cc75d.ishikodzume@beneath.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030304024714.647cc75d.ishikodzume@beneath.plus.com>; from ishikodzume@beneath.plus.com on Tue, Mar 04, 2003 at 02:47:14AM +0000
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 04, 2003  02:47 +0000, Beneath wrote:
> All of a sudden, and not during any heavy disk writing sessions or
> anything, things seem to stop loading up. I.e. the system is still very
> much alive, just anything that requires disk access will hang. It's
> happened both times in X, and i was able to switch back to VT1, where
> the following error messages awaited me:
> (this is as much as i could write down)
> 
> Several of these two messages:
> EXT3-FS error (device ide0(3,2)) in ext3 reserve_inode_write: IO failure
> EXT3-FS error (device ide0(3,2)) in ext3_get_inode ... (this then
> scrolled off the screen before i could transcribe it)

So, could you check in /var/log/messages (or whatever) to see if you
have the original error?  It might not have been written to disk if the
error is on the /var filesystem.  If that is the case, is it possible
for you to set up a serial console or network syslog to capture the
full errors?

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

