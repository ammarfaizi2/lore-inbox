Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbWFGOIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWFGOIb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 10:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWFGOIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 10:08:31 -0400
Received: from styx.suse.cz ([82.119.242.94]:36230 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932111AbWFGOIa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 10:08:30 -0400
Date: Wed, 7 Jun 2006 16:08:28 +0200
From: Jiri Benc <jbenc@suse.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: linville@tuxdriver.com, kernel list <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
Subject: Re: [patch] workaround zd1201 interference problem
Message-ID: <20060607160828.0045e7f5@griffin.suse.cz>
In-Reply-To: <20060607140045.GB1936@elf.ucw.cz>
References: <20060607140045.GB1936@elf.ucw.cz>
X-Mailer: Sylpheed-Claws 1.0.4a (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jun 2006 16:00:45 +0200, Pavel Machek wrote:
> +	zd1201_enable(zd);	/* zd1201 likes to startup shouting, interfering */
> +	zd1201_disable(zd); 	/* with all the wifis in range */

I would prefer to track it down and find out where exactly is the
problem instead of this quick hack.

 Jiri

-- 
Jiri Benc
SUSE Labs
