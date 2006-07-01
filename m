Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932486AbWGASJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbWGASJc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 14:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933073AbWGASJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 14:09:32 -0400
Received: from smtp1.ist.utl.pt ([193.136.128.21]:23748 "EHLO smtp1.ist.utl.pt")
	by vger.kernel.org with ESMTP id S932486AbWGASJb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 14:09:31 -0400
From: Claudio Martins <ctpm@ist.utl.pt>
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: ext4 features
Date: Sat, 1 Jul 2006 19:09:28 +0100
User-Agent: KMail/1.9.1
Cc: "Theodore Ts'o" <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de> <20060701170729.GB8763@irc.pl> <20060701174716.GC24570@cip.informatik.uni-erlangen.de>
In-Reply-To: <20060701174716.GC24570@cip.informatik.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200607011909.28685.ctpm@ist.utl.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Saturday 01 July 2006 18:47, Thomas Glanzmann wrote:
> Hello,
>
> > Checksums are not very useful for themselves. They are useful when we
> > have other copy of data (think raid mirroring) so data can be
> > reconstructed from working copy.
>
> it would be possible to identify data corruption.
>
> >   What's wrong with DM snapshots?
>
> they're inefficient in matter of disk space consumption because they
> don't have a clue of the filesystems that are on top of them.
>

 May I recommend that you have a look at NILFS?

 http://nilfs.org/en/

 The design is built from the ground up to support an almost arbitrary number 
of snapshots, and also has other advantages. And it works already.

Regards

Cláudio

