Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274809AbRIZD2q>; Tue, 25 Sep 2001 23:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274811AbRIZD2h>; Tue, 25 Sep 2001 23:28:37 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:55563 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S274809AbRIZD21>;
	Tue, 25 Sep 2001 23:28:27 -0400
Date: Tue, 25 Sep 2001 20:24:17 -0700
From: Greg KH <greg@kroah.com>
To: Crispin Cowan <crispin@wirex.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-security-module@wirex.com,
        linux-kernel@vger.kernel.org
Subject: Re: Binary only module overview
Message-ID: <20010925202417.A16558@kroah.com>
In-Reply-To: <E15lfKE-00047d-00@the-village.bc.nu> <3BB10E8E.10008@wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BB10E8E.10008@wirex.com>
User-Agent: Mutt/1.3.21i
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2001 at 04:09:02PM -0700, Crispin Cowan wrote:
> 
> Therefore, any additional constraints people may wish to impose, such as 
> Greg's comment in security.h, are invalid. When someone receives a copy 
> of the Linux kernel, the license is pure, vanilla GPL, with no funny 
> riders.*

My comment in security.h that I proposed [1] does not add any additional
constraints to the license that is currently on the file.  All it does
is explicitly state the licensing terms of it, so that there shall be no
confusion regarding it's inclusion in programs.  If you think this is
adding an additional restriction to the file, please explain.

If you were to include a GPL licensed user space header file in a closed
source program, of course you would be violating that license.  So why
do people think that since a file is in include/linux that the license
attached to that file is no longer valid?

Yes it is true that a variety of companies currently ship binary modules
for Linux.  And hopefully in the compilation of those modules they do
not include any GPL licensed header files.  I know some companies go to
great lengths to prevent this from happening.

thanks,

greg k-h

[1] Included here for those who did not see it on the
    linux-security-module mailing list:
	
	This file may not be included in any code not licensed
	under the list of accepted free software licenses as
	defined in module.h contained in this same directory.
