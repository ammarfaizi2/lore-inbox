Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbVDDMzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbVDDMzz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 08:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbVDDMzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 08:55:55 -0400
Received: from freelists-180.iquest.net ([206.53.239.180]:31377 "EHLO
	turing.freelists.org") by vger.kernel.org with ESMTP
	id S261160AbVDDMzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 08:55:50 -0400
From: John Madden <weez@freelists.org>
To: Jan Kara <jack@suse.cz>
Subject: Re: 2.6.11, nfsd, log_do_checkpoint()
Date: Mon, 4 Apr 2005 07:55:49 -0500
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <200504011927.19030.weez@freelists.org> <20050404093802.GC20219@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20050404093802.GC20219@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504040755.49190.weez@freelists.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Assertion failure in log_do_checkpoint() at fs/jbd/checkpoint.c:365:
> > "drop_count != 0 || cleanup_ret != 0"
>
>   Could you try running a kernel with the attached patch? Are you able to
> reproduce the problem even with the patch?

Funny thing: Assuming this was an ext3 problem, I moved the data to a reiserfs 
partition (with so many files, performance is an issue anyway) since the box 
is pretty critical.  I'll try to sneak some downtime in to try this out, but 
I can't make any promises...  The problem should be fairly easy to replicate 
in a lab though, if you're interested.

John



-- 
# John Madden  weez@freelists.org: http://www.nerdarium.com
# FreeLists: Free mailing lists for all: http://www.freelists.org
# Linux, Apache, Perl and C: All the best things in life are free!
