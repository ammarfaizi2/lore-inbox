Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267010AbSKUTcx>; Thu, 21 Nov 2002 14:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267008AbSKUTcx>; Thu, 21 Nov 2002 14:32:53 -0500
Received: from inet-mail2.oracle.com ([148.87.2.202]:60593 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id <S266859AbSKUTcv>; Thu, 21 Nov 2002 14:32:51 -0500
Date: Thu, 21 Nov 2002 11:39:51 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
Subject: Re: RFC - new raid superblock layout for md driver
Message-ID: <20021121193950.GD770@nic1-pc.us.oracle.com>
References: <20021120234743.GF29881@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021120234743.GF29881@marowsky-bree.de>
User-Agent: Mutt/1.4i
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2002 at 12:47:43AM +0100, Lars Marowsky-Bree wrote:
> However, for none-RAID devices like multipathing I believe that activating a
> drive on multiple hosts should be possible; ie, for these it might not be
> necessary to scribble to the superblock every time.

	Again, if you don't use persistent superblock and merely run the
mkraid from your initscripts (or initrd), raid0 and multipath work just
fine today.

Joel


-- 

"We will have to repent in this generation not merely for the
 vitriolic words and actions of the bad people, but for the 
 appalling silence of the good people."
	- Rev. Dr. Martin Luther King, Jr.

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
