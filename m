Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbTJDDAt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 23:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbTJDDAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 23:00:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57566 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261732AbTJDDAr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 23:00:47 -0400
Date: Sat, 4 Oct 2003 04:00:45 +0100
From: Matthew Wilcox <willy@debian.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       linux-hfsplus-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] new HFS(+) driver
Message-ID: <20031004030045.GD24824@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0310021029110.17548-100000@serv> <20031003070422.GA8627@werewolf.able.es> <Pine.LNX.4.44.0310031227460.17548-100000@serv> <20031003223904.GE30751@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031003223904.GE30751@werewolf.able.es>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 04, 2003 at 12:39:04AM +0200, J.A. Magallon wrote:
> I applied it, it just keeps mainstream files from including old hfs* files
> in include/linux, but the old files stay around (you end with two
> versions of hfs_fs.h, one in include/linux and other in fs/hfs...)
> I did not move anything, just deleted those old files. But as other
> filesystems put their xxxx_fs.h in include/linux, I thought that
> perhaps hfs(plus) should do the same.

actually more of these should move out of include/linux/

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
