Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265761AbUFIJmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265761AbUFIJmb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 05:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265770AbUFIJmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 05:42:31 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:24974 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265725AbUFIJmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 05:42:18 -0400
Date: Wed, 9 Jun 2004 11:42:18 +0200
From: Jan Kara <jack@suse.cz>
To: Timothy Miller <miller@techsource.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Increasing number of inodes after format?
Message-ID: <20040609094217.GA14564@atrey.karlin.mff.cuni.cz>
References: <40C62F2F.4090801@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40C62F2F.4090801@techsource.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was involved in a discussion a while back where it was explained that 
> ext2/3 allocate a certain maximum number of inodes at format time, and 
> you cannot increase that number later.
> 
> It was also mentioned that one or more of the journaling file systems 
> (XFS, JFS, Reiser, etc.) either dynamically allocated inodes or could 
> increase the maximum later if the pre-allocated set got used up.
> 
> Could someone please repeat for me which filesystems have dynamic 
> maximum inode counts?
  ReiserFS also does not have any particular limit on the number of inodes
(because it actually does not have any ;).

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
