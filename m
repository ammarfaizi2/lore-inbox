Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319600AbSIMK7D>; Fri, 13 Sep 2002 06:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319599AbSIMK7C>; Fri, 13 Sep 2002 06:59:02 -0400
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:58093 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S319600AbSIMK7C>; Fri, 13 Sep 2002 06:59:02 -0400
Date: Fri, 13 Sep 2002 11:59:52 +0200
From: Richard Zidlicky <rz@linux-m68k.org>
To: Syam Sundar V Appala <syam@cisco.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.19 Oops error
Message-ID: <20020913115952.A1796@linux-m68k.org>
References: <Pine.GSO.4.44.0209112015100.17831-100000@msabu-view1.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.44.0209112015100.17831-100000@msabu-view1.cisco.com>; from syam@cisco.com on Wed, Sep 11, 2002 at 08:23:09PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2002 at 08:23:09PM -0700, Syam Sundar V Appala wrote:
> Hello,
> I am relatively new to linux and I am facing the following problem. Can
> someone explain what is going on?
> 
> Oops:
> ---
> EXT2-fs error (device ide0(3,1)): ext2_check_page: bad entry in directory
> #21179
> 6: unaligned directory entry - offset=0, inode=4294967295, rec_len=65535,
> name_l
> en=255

some inode was ovewritten by 0xfffffff...., look back in the log for other
strange messages. Run memtest.

Richard

