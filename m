Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287467AbSAHASJ>; Mon, 7 Jan 2002 19:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287464AbSAHASA>; Mon, 7 Jan 2002 19:18:00 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18180 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S287471AbSAHARp>;
	Mon, 7 Jan 2002 19:17:45 -0500
Message-ID: <3C3A3AA6.A5055156@mandrakesoft.com>
Date: Mon, 07 Jan 2002 19:17:42 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.2-pre9fs7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolabs.com>
CC: Daniel Phillips <phillips@bonn-fries.net>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>, viro@math.psu.edu
Subject: Re: PATCH 2.5.2.9: ext2 unbork fs.h (part 1/7)
In-Reply-To: <20020107132121.241311F6A@gtf.org> <E16NbYF-0001Qq-00@starship.berlin> <3C3A33E2.D297F570@mandrakesoft.com> <20020107171500.L777@lynx.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> Could you be more specific?  AFAIK, the ext2_fs.h file is also used by
> e2fsprogs (which actually has its own, _more_ up-to-date version of this
> file), but the _i.h and _sb.h files are for kernel use only.  They do not
> have any relation to on-disk ext2 structs, so there would not really be
> any point in referencing them from userspace.

Just a based on the types and history of the file.  As noted in the
other e-mail, ext2_fs_sb.h has no such userspace restriction, I was
basically just being cautious :)

-- 
Jeff Garzik      | Alternate titles for LOTR:
Building 1024    | Fast Times at Uruk-Hai
MandrakeSoft     | The Took, the Elf, His Daughter and Her Lover
                 | Samwise Gamgee: International Hobbit of Mystery
