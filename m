Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbWFGOQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbWFGOQa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 10:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWFGOQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 10:16:29 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:14491 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932082AbWFGOQ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 10:16:29 -0400
Date: Wed, 7 Jun 2006 16:15:46 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jiri Benc <jbenc@suse.cz>
Cc: linville@tuxdriver.com, kernel list <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
Subject: Re: [patch] workaround zd1201 interference problem
Message-ID: <20060607141536.GD1936@elf.ucw.cz>
References: <20060607140045.GB1936@elf.ucw.cz> <20060607160828.0045e7f5@griffin.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060607160828.0045e7f5@griffin.suse.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On St 07-06-06 16:08:28, Jiri Benc wrote:
> On Wed, 7 Jun 2006 16:00:45 +0200, Pavel Machek wrote:
> > +	zd1201_enable(zd);	/* zd1201 likes to startup shouting, interfering */
> > +	zd1201_disable(zd); 	/* with all the wifis in range */
> 
> I would prefer to track it down and find out where exactly is the
> problem instead of this quick hack.

Well, I'll try _enable() alone, but it seems to me that _enable()
command is needed to initialize radio properly. I do not think we can
get much further without firmware sources...

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
