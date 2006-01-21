Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbWAUAI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbWAUAI0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 19:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbWAUAI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 19:08:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50388 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932135AbWAUAIY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 19:08:24 -0500
Date: Sat, 21 Jan 2006 01:08:06 +0100
From: Heinz Mauelshagen <mauelshagen@redhat.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Heinz Mauelshagen <mauelshagen@redhat.com>, Neil Brown <neilb@suse.de>,
       Phillip Susi <psusi@cfl.rr.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       "Lincoln Dale (ltd)" <ltd@cisco.com>, Michael Tokarev <mjt@tls.msk.ru>,
       linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: [PATCH 000 of 5] md: Introduction
Message-ID: <20060121000806.GT2801@redhat.com>
Reply-To: mauelshagen@redhat.com
References: <Pine.LNX.4.61.0601181427090.19392@yvahk01.tjqt.qr> <17358.52476.290687.858954@cse.unsw.edu.au> <43D00FFA.1040401@cfl.rr.com> <17360.5011.975665.371008@cse.unsw.edu.au> <43D02033.4070008@cfl.rr.com> <17360.9233.215291.380922@cse.unsw.edu.au> <20060120183621.GA2799@redhat.com> <20060120225724.GW22163@marowsky-bree.de> <20060121000142.GR2801@redhat.com> <20060121000344.GY22163@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060121000344.GY22163@marowsky-bree.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2006 at 01:03:44AM +0100, Lars Marowsky-Bree wrote:
> On 2006-01-21T01:01:42, Heinz Mauelshagen <mauelshagen@redhat.com> wrote:
> 
> > > Why not provide a dm-md wrapper which could then
> > > load/interface to all md personalities?
> > As we want to enrich the mapping flexibility (ie, multi-segment fine grained
> > mappings) of dm by adding targets as we go, a certain degree and transitional
> > existence of duplicate code is the price to gain that flexibility.
> 
> A dm-md wrapper would give you the same?

No, we'ld need to stack more complex to achieve mappings.
Think lvm2 and logical volume level raid5.

> 
> 
> Sincerely,
>     Lars Marowsky-Brée
> 
> -- 
> High Availability & Clustering
> SUSE Labs, Research and Development
> SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
> "Ignorance more frequently begets confidence than does knowledge"

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
