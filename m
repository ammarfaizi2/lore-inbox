Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263826AbTDUMGr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 08:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263827AbTDUMGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 08:06:47 -0400
Received: from verein.lst.de ([212.34.181.86]:37646 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S263826AbTDUMGq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 08:06:46 -0400
Date: Mon, 21 Apr 2003 14:18:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Oleg Drokin <green@namesys.com>
Cc: hch@lst.de, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: "[PATCH] devfs: switch over ubd to ->devfs_name" breaks ubd/sysfs
Message-ID: <20030421141845.A25822@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Oleg Drokin <green@namesys.com>, linux-kernel@vger.kernel.org,
	user-mode-linux-devel@lists.sourceforge.net
References: <20030421155530.A7544@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030421155530.A7544@namesys.com>; from green@namesys.com on Mon, Apr 21, 2003 at 03:55:30PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 21, 2003 at 03:55:30PM +0400, Oleg Drokin wrote:
> Hello!
> 
>    The "[PATCH] devfs: switch over ubd to ->devfs_name" patch that was included into 2.5.68,
>    have broken UML's ubd/sysfs interaction.
>    Sysfs is very upset when something tries to register several devices with 
>    same name, so I was forced to use following patch.
>    If this is wrong, then please explain to me why, and suggest the correct way of handling
>    this situation.

Patch looks okay to me.  But I'm still a bit confused about all
that fake_major stuff.  Someone care to explain it?

