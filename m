Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030229AbWFTLzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbWFTLzy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 07:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030234AbWFTLzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 07:55:53 -0400
Received: from p54AFEA14.dip.t-dialin.net ([84.175.234.20]:23942 "EHLO
	o.ww.redhat.com") by vger.kernel.org with ESMTP id S1030229AbWFTLzw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 07:55:52 -0400
Date: Tue, 20 Jun 2006 13:55:45 +0200
From: Heinz Mauelshagen <mauelshagen@redhat.com>
To: CaT <cat@zip.com.au>
Cc: Heinz Mauelshagen <mauelshagen@redhat.com>, linux-kernel@vger.kernel.org,
       dm-devel@redhat.com
Subject: Re: 2.6.16.20/dm: can't create more then one snapshot of an lv
Message-ID: <20060620115545.GB4566@redhat.com>
Reply-To: mauelshagen@redhat.com
References: <20060619020040.GX2059@zip.com.au> <20060620005405.GY2059@zip.com.au> <20060620100209.GA4566@redhat.com> <20060620114613.GZ2059@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060620114613.GZ2059@zip.com.au>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2006 at 09:46:13PM +1000, CaT wrote:
> On Tue, Jun 20, 2006 at 12:02:09PM +0200, Heinz Mauelshagen wrote:
> > How many snapshots active at once ?
> 
> 1. I can start more then 1 premade snapshots just fine and use them
> but the moment I add another one a freeze occurs.

Well, that's fairly few ;)

> 
> > I guess this is a kcopyd scalability issue which needs addressing.
> 
> Well in the end I'm hoping to get at least 7. Hopefully that's not
> insane. :)

No, I was assuming, you were trying to activate plenty.

FYI: the snapshot code in 2.6.17-rc has received a fair amount of fixes
     which might help this vs. 2.6.16.20.

> 
> -- 
>     "To the extent that we overreact, we proffer the terrorists the
>     greatest tribute."
>     	- High Court Judge Michael Kirby

-- 

Regards,
Heinz    -- The LVM Guy --

*** Software bugs are stupid.
    Nevertheless it needs not so stupid people to solve them ***

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Heinz Mauelshagen                                 Red Hat GmbH
Consulting Development Engineer                   Am Sonnenhang 11
Storage Development                               56242 Marienrachdorf
                                                  Germany
Mauelshagen@RedHat.com                            PHONE +49  171 7803392
                                                  FAX   +49 2626 924446
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
