Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbVHHQCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbVHHQCO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 12:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbVHHQCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 12:02:14 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:6566 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932095AbVHHQCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 12:02:14 -0400
Date: Mon, 8 Aug 2005 18:02:05 +0200
From: Jan Kara <jack@suse.cz>
To: Mark Bellon <mbellon@mvista.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH]  (TAKE 3) disk quotas fail when /etc/mtab is symlinked to /proc/mounts
Message-ID: <20050808160205.GC8831@atrey.karlin.mff.cuni.cz>
References: <42E97236.6080404@mvista.com> <42EA6580.9010204@mvista.com> <42EAA7C8.5010206@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42EAA7C8.5010206@mvista.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  so I returned back and looked at the patch. It's fine. I only suggest
changing of the message:
> +			printk(KERN_ERR
> +				"EXT3-fs: old and new quota format mixing.\n");
  As a user is not mixing the old and the new quota format but the
journaled and the unjournaled quota...

								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
