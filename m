Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264289AbTKMOfc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 09:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264301AbTKMOfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 09:35:32 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:44507 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264289AbTKMOfa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 09:35:30 -0500
Date: Thu, 13 Nov 2003 15:35:21 +0100
From: Jens Axboe <axboe@suse.de>
To: Pascal Schmidt <der.eremit@email.de>
Cc: Bill Davidsen <davidsen@tmr.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
Message-ID: <20031113143521.GK4441@suse.de>
References: <20031113122039.GJ4441@suse.de> <Pine.LNX.4.44.0311131418070.947-100000@neptune.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311131418070.947-100000@neptune.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 13 2003, Pascal Schmidt wrote:
> On Thu, 13 Nov 2003, Jens Axboe wrote:
> 
> >> Are there any cases when the last_written size is really what's wanted,
> >> rather than the capacity? Such as unclosed multi-session iso9660, ufs, or
> >> whatever else I'm ignoring?
> > Yes, for packet written media.
>  
> My patch from yesterday should handle that situation. 
> cdrom_get_last_written is allowed to override the capacity from
> cdrom_read_capacity.

Yep, that is fine.

-- 
Jens Axboe

