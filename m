Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161299AbWASKA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161299AbWASKA4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 05:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161301AbWASKA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 05:00:56 -0500
Received: from pm-mx5.mgn.net ([195.46.220.209]:10936 "EHLO pm-mx5.mx.noos.fr")
	by vger.kernel.org with ESMTP id S1161299AbWASKAz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 05:00:55 -0500
Date: Thu, 19 Jan 2006 10:56:30 +0100
From: Damien Wyart <damien.wyart@free.fr>
To: Jeff Mahoney <jeffm@suse.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       vitaly@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1 + reiser* from -rc1-mm1 : BUG with reiserfs
Message-ID: <20060119095630.GA27258@localhost.localdomain>
References: <20060118122631.GA12363@localhost.localdomain> <43CEC61E.2040500@suse.com> <200601190004.36549.rjw@sisk.pl> <43CECC7D.1090200@suse.com> <20060119094205.GA14907@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20060119094205.GA14907@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> New test this morning with latest 2.6.16-rc1-git pulled with git, and
> all reiserfs and reiser4 patches from -rc1-mm1, EXCEPT the three
> on-demand bitmap for reiserfs. And when booting, the systems half
> crashes with this error. So I guess the bad patches are not only the
> ones for on-demand bitmap...

Oops, sorry, I forgot : I also had applied this patch from Vitaly (not
that I needed it, but testing is always fun)
http://marc.theaimsgroup.com/?l=reiserfs&m=113760949914913

maybe this could be related or incompatible with the reiserfs patches
from mm...

-- 
Damien Wyart
