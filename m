Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269954AbTGVHMX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 03:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270013AbTGVHMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 03:12:23 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:6667 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S269954AbTGVHMW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 03:12:22 -0400
Date: Tue, 22 Jul 2003 09:27:24 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: andreas baeurle <a.baeurle@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: XP vfat partitions
Message-ID: <20030722092724.A12135@pclin040.win.tue.nl>
References: <bfechu$tse$1@main.gmane.org> <20030721175147.GD1158@matchmail.com> <bfhp94$1cr$1@main.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <bfhp94$1cr$1@main.gmane.org>; from a.baeurle@web.de on Tue, Jul 22, 2003 at 12:22:46AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 22, 2003 at 12:22:46AM +0200, andreas baeurle wrote:
> Mike Fedyk wrote:
> 
> > On Sun, Jul 20, 2003 at 05:27:03PM +0200, andreas wrote:
> >> My question is howto mount a Xp-vfat partition with 2.6 kernel.
> >> In my fstab is following entry:
> >> /dev/hda2       /windows/C      vfat   
> >> users,gid=users,umask=0002,iocharset=iso8859-1 code=437 0 0

> I have 3 Partitions with vfat
> the error message is:
> <3>FAT: Unrecognized mount option code
> <3>FAT: Unrecognized mount option code
> <3>FAT: Unrecognized mount option code
> in boot.msg

I suppose things will be better if you replace ' code' by ',codepage'.

This message tells you that there is no vfat mount option 'code'.

