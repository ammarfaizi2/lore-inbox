Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288845AbSATRcN>; Sun, 20 Jan 2002 12:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288854AbSATRcD>; Sun, 20 Jan 2002 12:32:03 -0500
Received: from mail.zmailer.org ([194.252.70.162]:3968 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S288851AbSATRb7>;
	Sun, 20 Jan 2002 12:31:59 -0500
Date: Sun, 20 Jan 2002 19:31:41 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: Richard Guenther <rguenth@tat.physik.uni-tuebingen.de>,
        Oliver Paukstadt <pstadt@stud.fh-heilbronn.de>,
        Linux-Kernel <linux-kernel@vger.kernel.org>,
        linux-raid@vger.kernel.org
Subject: Re: 2.4.17 RAID-1 EXT3  reliable to hang....
Message-ID: <20020120193141.A1112@mea-ext.zmailer.org>
In-Reply-To: <Pine.LNX.4.33.0201070933590.4076-100000@lola.stud.fh-heilbronn.de> <Pine.LNX.4.33.0201071047410.17279-100000@bellatrix.tat.physik.uni-tuebingen.de> <3C3973D9.CF689345@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C3973D9.CF689345@zip.com.au>; from akpm@zip.com.au on Mon, Jan 07, 2002 at 02:09:29AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2002 at 02:09:29AM -0800, Andrew Morton wrote:
...
> I spent *ages* on the ext3 buffer writeout code and it's still not
> ideal.  Can you test with this patch applied?
> 
> http://www.zipworld.com.au/~akpm/linux/2.4/2.4.18-pre1/mini-ll.patch
> 
> It should go into 2.4.17 OK.

   I just tried this into  2.4.18-pre4  and it still hard-hangs
   the RAID-1 + EXT3 on SMP.

/Matti Aarnio
