Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132434AbQLJVKM>; Sun, 10 Dec 2000 16:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132820AbQLJVKC>; Sun, 10 Dec 2000 16:10:02 -0500
Received: from Cantor.suse.de ([194.112.123.193]:48648 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132434AbQLJVJx>;
	Sun, 10 Dec 2000 16:09:53 -0500
Date: Sun, 10 Dec 2000 21:39:38 +0100
From: Jens Axboe <axboe@suse.de>
To: Frank van Maarseveen <F.vanMaarseveen@inter.NL.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test11 EXT2 corruption (3)
Message-ID: <20001210213938.D294@suse.de>
In-Reply-To: <20001210161723.A1060@iapetus.localdomain> <20001210183101.A6947@iapetus.localdomain> <20001210213500.A17413@iapetus.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001210213500.A17413@iapetus.localdomain>; from F.vanMaarseveen@inter.NL.net on Sun, Dec 10, 2000 at 09:35:00PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10 2000, Frank van Maarseveen wrote:
> Hmm, not only I see files stuffed with random data but sometimes also with
> a block of zeroes (about 3600 consecutive zero bytes in a .depend
> file) At one time /var/log/messages said while doing rm -rf:
> 
> Dec 10 21:23:04 iapetus kernel: EXT2-fs error (device ide0(3,4)):
> ext2_readdir: bad entry in directory #152149: rec_len is smaller than
> minimal - offset=0, inode=0, rec_len=0, name_len=0 Dec 10 21:23:04
> iapetus kernel: EXT2-fs warning (device ide0(3,4)): empty_dir: bad
> directory (dir #152149) - no `.' or `..' Dec 10 21:23:05 iapetus
> kernel: EXT2-fs error (device ide0(3,4)): ext2_readdir: bad entry in
> directory #332361: rec_len is smaller than minimal - offset=0,
> inode=0, rec_len=0, name_len=0 Dec 10 21:23:05 iapetus kernel: EXT2-fs
> warning (device ide0(3,4)): empty_dir: bad directory (dir #332361) -
> no `.' or `..'
> 
> Maybe it is a hardware problem?

No, it's a test11 problem. Go to test12-pre[latest].

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
