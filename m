Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbTJSQAL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 12:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbTJSQAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 12:00:11 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:44030 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261916AbTJSQAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 12:00:06 -0400
Date: Sun, 19 Oct 2003 17:59:59 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] add a config option for -Os compilation
Message-ID: <20031019155958.GA23191@fs.tum.de>
References: <20031018105733.380ea8d2.akpm@osdl.org> <668910000.1066578207@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <668910000.1066578207@[10.10.2.4]>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 19, 2003 at 08:43:27AM -0700, Martin J. Bligh wrote:
>...
> So why are we changing it then? ;-) We don't seem to have much evidence
> either way. What are the distros doing?

The exact speed differences need measurements and it might be that
depending on the gcc version and hardware the one or the other is 
faster.

I doubt it would make a noticalble difference in either direction for an
average user who runs Mozilla under KDE. -O2 is IMHO the better default 
since it's well tested through different gcc versions.

The more important point is that -Os code is significantely smaller 
which is important for some applications (e.g. a router-on-a-floppy or 
small embedded systems).

> M.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

