Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbWJFLyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbWJFLyb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 07:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbWJFLyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 07:54:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:6569 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932192AbWJFLya convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 07:54:30 -0400
X-Authenticated: #19095397
From: Bernd Schubert <bernd-schubert@gmx.de>
To: Jan Kara <jack@suse.cz>
Subject: Re: quota problem with 2.6.15.7
Date: Fri, 6 Oct 2006 13:55:10 +0200
User-Agent: KMail/1.9.4
Cc: reiserfs-list@namesys.org, linux-kernel@vger.kernel.org
References: <200609021557.03885.bernd-schubert@gmx.de> <20060905091924.GC3830@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20060905091924.GC3830@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610061355.11146.bernd-schubert@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jan,

On Tuesday 05 September 2006 11:19, Jan Kara wrote:
>   Hmm, the trace looks strange... It is definitely mixed with some old
> data. We definitely reached reiserfs_quota_on() but didn't reach
> vfs_quota_on() so it seems we crashed somewhere in path_lookup() (also
> link_path_walk() in the beginning of the trace suggests that). That's
> generic VFS code so maybe this is nothing quota specific. So this looks
> quite hard to debug if there's no reasonable way of reproducing it.

I couldn't reproduce it with a vanilla kernel, but just was told (from the 
people who compiled the patched kernel) that its due to lustre patches.


Thanks again for your help,
Bernd

-- 
Bernd Schubert
PCI / Theoretische Chemie
Universität Heidelberg
INF 229
69120 Heidelberg

