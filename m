Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315374AbSGEE63>; Fri, 5 Jul 2002 00:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315388AbSGEE62>; Fri, 5 Jul 2002 00:58:28 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:5605 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S315374AbSGEE61>; Fri, 5 Jul 2002 00:58:27 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Alexander Viro <viro@math.psu.edu>
Date: Fri, 5 Jul 2002 14:02:08 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15653.6720.628807.611023@notabene.cse.unsw.edu.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] raid kdev_t cleanups (part 1)
In-Reply-To: message from Alexander Viro on Friday July 5
References: <Pine.GSO.4.21.0207050049460.14718-100000@weyl.math.psu.edu>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday July 5, viro@math.psu.edu wrote:
> 	* ->error_handler() switched to struct block_device *.
> 	* md_sync_acct() switched to struct block_device *.
> 	* raid5 struct disk_info ->dev is gone - we use ->bdev everywhere.
> 	* bunch of kdev_same() when we have corresponding struct block_device *
> and can simply compare them is removed from drivers/md/*.c

I've actually got a whole bunch of md stuff pending that covers all
this and more... could you hold off a few days until I get it
submitted so that I don't have to re-merge??

NeilBrown
