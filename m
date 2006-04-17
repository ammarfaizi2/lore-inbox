Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbWDQMsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWDQMsK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 08:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbWDQMsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 08:48:09 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:43786 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750804AbWDQMsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 08:48:08 -0400
Date: Mon, 17 Apr 2006 14:48:07 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Takashi Sato <sho@bsd.tnes.nec.co.jp>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
       Ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] [RFC][15/21]e2fsprogs modify variables for bitmap to exceed 2G
Message-ID: <20060417124807.GB7429@stusta.de>
References: <20060413161227sho@rifu.tnes.nec.co.jp> <20060413162028.GA23452@thunk.org> <020501c6621a$bf158c50$4168010a@bsd.tnes.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <020501c6621a$bf158c50$4168010a@bsd.tnes.nec.co.jp>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2006 at 09:30:39PM +0900, Takashi Sato wrote:
> Thank you for your comment, Ted.
> 
> >Generalized NACK.  We can't just blindly change function signatures of
> >pre-existing functions in libext2fs, since this breaks the ABI with
> >pre-existing applications linked with current shared libraries of
> >libext2fs.
> 
> Though I checked if there are any commands which use the following
> functions in RHEL4, no such commands were found except in e2fsprogs
> itself.
>...
> ext2fs_test_block_bitmap()
>...

Used by e2undel [1].

> So I think changing these function signatures does not break the ABI
> practically.  Am I missing something?
> 
> Cheers, sho

cu
Adrian

[1] http://e2undel.sourceforge.net/

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

