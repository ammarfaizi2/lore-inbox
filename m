Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312426AbSCYO04>; Mon, 25 Mar 2002 09:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312427AbSCYO0q>; Mon, 25 Mar 2002 09:26:46 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:6411 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S312426AbSCYO0h>; Mon, 25 Mar 2002 09:26:37 -0500
Date: Mon, 25 Mar 2002 15:26:29 +0100
From: Jan Kara <jack@suse.cz>
To: John_Delisle@Ceridian.ca
Cc: linux-kernel@vger.kernel.org
Subject: Re: inode-max missing?
Message-ID: <20020325142629.GJ14507@atrey.karlin.mff.cuni.cz>
In-Reply-To: <OFF1E4D08F.3F7F86A6-ON86256B86.0079B50E@ho.ceridian.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> I'm trying to fix a problem "too many open files" by adjusting
> /proc/sys/fs/inode-max but I don't have one, it's missing.  I've gone
> through the docs and they all reference it, but it's missing from parts of
> the source susch as sysctl.c.
> 
> I'm running 2.4.18, btw.
  As inodes are allocated dynamically in 2.4.18 so this file doesn't exist
any more. What might interest you more is file /proc/sys/fs/file-max. Also
check whether you don't have set limit on number of open files by ulimit.

								Honza
