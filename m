Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbTJFTir (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 15:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbTJFTiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 15:38:46 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:49678
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S261644AbTJFTim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 15:38:42 -0400
Date: Mon, 6 Oct 2003 12:38:41 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Brad Boyer <flar@allandria.com>
Cc: linux-hfsplus-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] new HFS(+) driver
Message-ID: <20031006193841.GA1366@matchmail.com>
Mail-Followup-To: Brad Boyer <flar@allandria.com>,
	linux-hfsplus-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0310021029110.17548-100000@serv> <20031002180645.GG7665@parcelfarce.linux.theplanet.co.uk> <20031002185248.GA24046@pants.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031002185248.GA24046@pants.nu>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 02, 2003 at 11:52:48AM -0700, Brad Boyer wrote:
> On Thu, Oct 02, 2003 at 07:06:45PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> > What the devil are you doing with get_gendisk() in there?  Neither 2.4
> > nor 2.6 should be messing with it.
> 
> Since this topic has come up, I'd like to ask about something that
> apparently only affects HFS/HFS+. For some reason, Apple decided
> that a Mac style CD-ROM should be a partitioned device. However,
> the Linux kernel is quite insistent that a CD-ROM is not able to
> be partitioned. Because of this, there's a hack to manually read
> a partition map and find the correct part of the block device.
> 

Where can I find this hack?  I just had three CDs from cleints that have
partition maps on them...

I've read them on our Mac (OS9.2), but I'd love to know how to read them
under linux!
