Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262915AbREWAOV>; Tue, 22 May 2001 20:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262916AbREWAOL>; Tue, 22 May 2001 20:14:11 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:6662 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262913AbREWAN4>;
	Tue, 22 May 2001 20:13:56 -0400
Date: Wed, 23 May 2001 02:14:02 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Martin Dalecki <dalecki@evision-ventures.com>, Andries.Brouwer@cwi.nl,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        viro@math.psu.edu
Subject: Re: [PATCH] struct char_device
Message-ID: <20010523021402.A29489@suse.de>
In-Reply-To: <UTC200105222217.AAA79157.aeb@vlet.cwi.nl> <3B0AEC76.F5B425F5@evision-ventures.com> <3B0AFE0C.8392E7C4@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22 2001, Jeff Garzik wrote:
> IMHO it would be nice to (for 2.4) create wrappers for accessing the
> block arrays, so that we can more easily dispose of the arrays when 2.5
> rolls around...

Agreed, in fact I have a lot of stuff that could be included in the
kcompat files for 2.4 (of course still changing :)

BTW, max_sectors/max_segments/hardsect_size already in place. Still some
to go.

-- 
Jens Axboe

