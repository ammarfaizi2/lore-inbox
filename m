Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263567AbUECNsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263567AbUECNsi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 09:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263712AbUECNsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 09:48:38 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:62366 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263567AbUECNsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 09:48:37 -0400
Date: Mon, 3 May 2004 11:59:47 +0200
From: Pavel Machek <pavel@suse.cz>
To: Junfeng Yang <yjf@stanford.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, mc@stanford.edu,
       Madanlal S Musuvathi <madan@stanford.edu>,
       "David L. Dill" <dill@cs.stanford.edu>
Subject: Re: [Ext2-devel] [CHECKER] warnings in fs/ext3/namei.c (2.4.19) where disk read errors get ignored, causing non-empty dir to be deleted
Message-ID: <20040503095947.GD468@openzaurus.ucw.cz>
References: <Pine.GSO.4.44.0404262339360.7250-100000@elaine24.Stanford.EDU> <20040427074455.GD30529@schnapps.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040427074455.GD30529@schnapps.adilger.int>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I'm not sure if they are real bugs or not, so your confirmations
> > /clarifications are appericated.
> 
> I don't consider this a bug, but rather a conscious decision on the part of
> the developers.  If you are trying to delete a directory and it has read
> errors, then it is better to let the unlink succeed than to refuse to unlink
> the directory.

Perhaps this should be documented with a comment?
Its rather subtle.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

