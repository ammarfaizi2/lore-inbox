Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423179AbWJQIu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423179AbWJQIu6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 04:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423180AbWJQIu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 04:50:58 -0400
Received: from p54AFDC7E.dip.t-dialin.net ([84.175.220.126]:22404 "EHLO
	o.ww.redhat.com") by vger.kernel.org with ESMTP id S1423179AbWJQIu5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 04:50:57 -0400
Date: Tue, 17 Oct 2006 10:50:22 +0200
From: Heinz Mauelshagen <mauelshagen@redhat.com>
To: Alasdair G Kergon <agk@redhat.com>, Phillip Susi <psusi@cfl.rr.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Heinz Mauelshagen <mauelshagen@redhat.com>
Subject: Re: dm stripe: Fix bounds
Message-ID: <20061017085022.GB4800@redhat.com>
Reply-To: mauelshagen@redhat.com
References: <20060316151114.GS4724@agk.surrey.redhat.com> <452DBE11.2000005@cfl.rr.com> <20061012135945.GV17654@agk.surrey.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061012135945.GV17654@agk.surrey.redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2006 at 02:59:45PM +0100, Alasdair G Kergon wrote:
> On Thu, Oct 12, 2006 at 12:01:21AM -0400, Phillip Susi wrote:
> > now dmraid fails to configure the dm 
> > table because this patch rejects it.
>  
> > I believe the correct thing to do is to special case the last stripe in 
> > 0-31    64-67
> > 32-63   68-71
>  
> AFAIK current versions of dmraid handle this correctly - Heinz?

Yes, that's correct.

> 
> Alasdair
> -- 
> agk@redhat.com

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
