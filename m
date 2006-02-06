Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbWBFOt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbWBFOt0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 09:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWBFOtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 09:49:25 -0500
Received: from rtr.ca ([64.26.128.89]:22410 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932140AbWBFOtY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 09:49:24 -0500
Message-ID: <43E761EB.3030203@rtr.ca>
Date: Mon, 06 Feb 2006 09:49:15 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <nigel@suspend2.net>, Rafael Wysocki <rjw@sisk.pl>,
       linux-kernel@vger.kernel.org,
       Suspend2 Devel List <suspend2-devel@lists.suspend2.net>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2]
 Modules support.)
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602041954.22484.nigel@suspend2.net> <20060204192924.GC3909@elf.ucw.cz> <200602061402.54486.nigel@suspend2.net> <20060206105954.GD3967@elf.ucw.cz>
In-Reply-To: <20060206105954.GD3967@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >I'm not sure if we want to save full image of memory. Saving most-used
 >caches only seems to work fairly well.

No, it sucks.  My machines take forever to become usable on resume
with the current method.  But dumping full image of memory will need
compression to keep that from being sluggish as well.

Mmm.. I think I need to install swsusp2 here.

Cheers
