Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932437AbWAWJp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbWAWJp2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 04:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbWAWJp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 04:45:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:10916 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932431AbWAWJp0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 04:45:26 -0500
Date: Mon, 23 Jan 2006 10:44:18 +0100
From: Heinz Mauelshagen <mauelshagen@redhat.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Heinz Mauelshagen <mauelshagen@redhat.com>, Neil Brown <neilb@suse.de>,
       Phillip Susi <psusi@cfl.rr.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       "Lincoln Dale (ltd)" <ltd@cisco.com>, Michael Tokarev <mjt@tls.msk.ru>,
       linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: [PATCH 000 of 5] md: Introduction
Message-ID: <20060123094418.GX2801@redhat.com>
Reply-To: mauelshagen@redhat.com
References: <43D00FFA.1040401@cfl.rr.com> <17360.5011.975665.371008@cse.unsw.edu.au> <43D02033.4070008@cfl.rr.com> <17360.9233.215291.380922@cse.unsw.edu.au> <20060120183621.GA2799@redhat.com> <20060120225724.GW22163@marowsky-bree.de> <20060121000142.GR2801@redhat.com> <20060121000344.GY22163@marowsky-bree.de> <20060121000806.GT2801@redhat.com> <20060121001311.GA22163@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060121001311.GA22163@marowsky-bree.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2006 at 01:13:11AM +0100, Lars Marowsky-Bree wrote:
> On 2006-01-21T01:08:06, Heinz Mauelshagen <mauelshagen@redhat.com> wrote:
> 
> > > A dm-md wrapper would give you the same?
> > No, we'ld need to stack more complex to achieve mappings.
> > Think lvm2 and logical volume level raid5.
> 
> How would you not get that if you had a wrapper around md which made it
> into an dm personality/target?

You could with deeper stacking. That's why I mentioned it above.

> 
> Besides, stacking between dm devices so far (ie, if I look how kpartx
> does it, or LVM2 on top of MPIO etc, which works just fine) is via the
> block device layer anyway - and nothing stops you from putting md on top
> of LVM2 LVs either.
> 
> I use the regularly to play with md and other stuff...

Me too but for production, I want to avoid the
additional stacking overhead and complexity.

> 
> So I remain unconvinced that code duplication is worth it for more than
> "hark we want it so!" ;-)

Shall I remove you from the list of potential testers of dm-raid45 then ;-)

> 
> 

-- 

Regards,
Heinz    -- The LVM Guy --

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Heinz Mauelshagen                                 Red Hat GmbH
Consulting Development Engineer                   Am Sonnenhang 11
Cluster and Storage Development                   56242 Marienrachdorf
                                                  Germany
Mauelshagen@RedHat.com                            +49 2626 141200
                                                       FAX 924446
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
