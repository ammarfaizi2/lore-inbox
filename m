Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263823AbTGFVsT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 17:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbTGFVsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 17:48:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50821 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263823AbTGFVsR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 17:48:17 -0400
Message-ID: <3F089C74.6070005@pobox.com>
Date: Sun, 06 Jul 2003 18:02:28 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Paul.Clements@steeleye.com
CC: akpm@digeo.com, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH 2.5.74-mm2] nbd: make nbd and block layer agree about
 device and  block sizes
References: <Pine.LNX.4.10.10307061750040.764-100000@clements.sc.steeleye.com>
In-Reply-To: <Pine.LNX.4.10.10307061750040.764-100000@clements.sc.steeleye.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Clements wrote:
> On Sun, 6 Jul 2003, Jeff Garzik wrote:
>>Also, I wonder if you found a bug/oversight in set_blocksize -- it sets 
>>bd_inode->i_blkbits but not bd_inode->i_size.  I think it should set 
>>i_size also.  Maybe Andrew or Al can confirm/refute this assertion.
> 
> 
> OK, I'll wait for a response on this, and then redo the patch as appropriate...


No, nevermind.  What I was said dumb ;-)

The inode's size should not be the block size.

	Jeff



