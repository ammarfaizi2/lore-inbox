Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261319AbVEQIAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbVEQIAI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 04:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVEQIAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 04:00:07 -0400
Received: from colino.net ([213.41.131.56]:11253 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S261338AbVEQIAB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 04:00:01 -0400
Date: Tue, 17 May 2005 09:59:52 +0200
From: Colin Leroy <colin@colino.net>
To: linux-kernel@vger.kernel.org
Cc: "Michael H. Warfield" <mhw@wittsend.com>
Subject: Re: Sync option destroys flash!
Message-ID: <20050517095952.740f7174@colin.toulouse>
X-Mailer: Sylpheed-Claws 1.9.9 (GTK+ 2.4.9; i686-pc-linux-gnu)
In-Reply-To: <1116001207.5239.38.camel@localhost.localdomain>
References: <1116001207.5239.38.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> According to the man pages for mount, FAT and VFAT
> file systems ignore the "sync" option.  It lies.  Maybe it use to be
> true, but it certainly lies now. 

Yes, it does lie. I'm the author of the O_SYNC patch for fat and vfat,
and I'd like to point out that I did test a few flash drives (and hard
drives) extensively (during about a week) with this flag, and they did
not die on me.
As other people said, I think the O_SYNC handling does exactly what it
says, and if it doesn't do what you want, tell HAL not to set it (There
must be a way).

-- 
Colin
