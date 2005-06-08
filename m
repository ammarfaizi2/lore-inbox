Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262157AbVFHKEB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262157AbVFHKEB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 06:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262154AbVFHKEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 06:04:01 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:23171 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262157AbVFHKDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 06:03:41 -0400
Date: Wed, 8 Jun 2005 12:03:48 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Alexander Nyberg <alexn@telia.com>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com
Subject: Re: RFC: i386: kill !4KSTACKS
Message-ID: <20050608100348.GB331@wohnheim.fh-wedel.de>
References: <20050607212706.GB7962@stusta.de> <1118180858.956.27.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1118180858.956.27.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 June 2005 23:47:38 +0200, Alexander Nyberg wrote:
> tis 2005-06-07 klockan 23:27 +0200 skrev Adrian Bunk:
> > 4Kb kernel stacks are the future on i386, and it seems the problems it 
> > initially caused are now sorted out.
> > 
> > I'd like to:
> > - get a patch into the next -mm that unconditionally enables 4KSTACKS
> > - if there won't be new reports of breakages, send a patch to
> >   completely remove !4KSTACKS for 2.6.13 or 2.6.14
> > 
> 
> Combinations of IDE/SCSI with MD/DM (maybe even stacking them ontop of
> eachother), NFS and a filesystem in there breaks 4KSTACKS which is a
> known issue so you can't just remove it leaving users with no choice.
> 
> This was not even difficult to trigger a while ago and I haven't seen
> any stack reduction patches in these areas.

Can you send me a backtrace for one such dump?  I'd like to use that
for some pessimistic checker runs.

Jörn

-- 
Good warriors cause others to come to them and do not go to others.
-- Sun Tzu
