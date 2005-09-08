Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964996AbVIHUgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbVIHUgK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 16:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965000AbVIHUgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 16:36:10 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:24207 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S964996AbVIHUgI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 16:36:08 -0400
Date: Thu, 8 Sep 2005 22:37:15 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Fabian LoneStar Fr?d?rick <fabian.frederick@gmx.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: git_linux addition ; genericity pls
Message-ID: <20050908203715.GA26675@mars.ravnborg.org>
References: <17416.1126211209@www78.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17416.1126211209@www78.gmx.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2005 at 10:26:49PM +0200, "Fabian LoneStar Fr?d?rick" wrote:
> Hi,
> 
>    I know git's made for any kind of _big_ project out there but what about
> having git_linux cmd or something to do all the stuff (create path, cloning,
> download, readtree, checkout, make oldconf, make, export stuff ... ) ? I do
> feel somekind of a regression in front of install_latest_kernel ease of
> use.Did I miss something ?

cogito?

cg-clone \
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/linus/linux-2.6.git \
linux-2.6.git

cd linux-2.6
make menuconfig

See http://www.kernel.org/git for cogito pointers.

	Sam
