Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311404AbSCSQOe>; Tue, 19 Mar 2002 11:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311411AbSCSQOZ>; Tue, 19 Mar 2002 11:14:25 -0500
Received: from angband.namesys.com ([212.16.7.85]:41088 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S311404AbSCSQOI>; Tue, 19 Mar 2002 11:14:08 -0500
Date: Tue, 19 Mar 2002 19:13:59 +0300
From: Oleg Drokin <green@namesys.com>
To: Christian Robert <christian.robert@polymtl.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unable to run kernel 2.4.18  it panic at boot
Message-ID: <20020319191359.A8533@namesys.com>
In-Reply-To: <3C96C714.E6967570@polymtl.ca> <20020319085943.B4750@namesys.com> <3C976267.71756479@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, Mar 19, 2002 at 11:08:07AM -0500, Christian Robert wrote:

> I have reiserfs, but no hpfs partitions ( but yes, it is compiled in the kernel )
> my next step will be to recompile kernel without "hpfs" to see if it help.
>  
Yes, it should
Or alternatively you can move reiserfs up in the list of objects to be linked
in /usr/src/linux/fs/Makefile

Bye,
    Oleg
