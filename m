Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932563AbWGARrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932563AbWGARrS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 13:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932947AbWGARrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 13:47:18 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:25061 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S932563AbWGARrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 13:47:18 -0400
Date: Sat, 1 Jul 2006 19:47:16 +0200
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
To: "Theodore Ts'o" <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features
Message-ID: <20060701174716.GC24570@cip.informatik.uni-erlangen.de>
Mail-Followup-To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Theodore Ts'o <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de> <20060701170729.GB8763@irc.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060701170729.GB8763@irc.pl>
User-Agent: Mutt/1.5.11-2006-06-13
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> Checksums are not very useful for themselves. They are useful when we
> have other copy of data (think raid mirroring) so data can be
> reconstructed from working copy.

it would be possible to identify data corruption.

>   What's wrong with DM snapshots?

they're inefficient in matter of disk space consumption because they
don't have a clue of the filesystems that are on top of them.

        Thomas
