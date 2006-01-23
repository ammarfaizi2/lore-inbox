Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbWAWLBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbWAWLBY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 06:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWAWLBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 06:01:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34249 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751124AbWAWLBX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 06:01:23 -0500
Date: Mon, 23 Jan 2006 12:00:06 +0100
From: Heinz Mauelshagen <mauelshagen@redhat.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Heinz Mauelshagen <mauelshagen@redhat.com>, Neil Brown <neilb@suse.de>,
       Phillip Susi <psusi@cfl.rr.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       "Lincoln Dale (ltd)" <ltd@cisco.com>, Michael Tokarev <mjt@tls.msk.ru>,
       linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: [PATCH 000 of 5] md: Introduction
Message-ID: <20060123110006.GZ2801@redhat.com>
Reply-To: mauelshagen@redhat.com
References: <20060120183621.GA2799@redhat.com> <20060120225724.GW22163@marowsky-bree.de> <20060121000142.GR2801@redhat.com> <20060121000344.GY22163@marowsky-bree.de> <20060121000806.GT2801@redhat.com> <20060121001311.GA22163@marowsky-bree.de> <20060123094418.GX2801@redhat.com> <20060123102601.GD2366@marowsky-bree.de> <20060123103851.GY2801@redhat.com> <20060123104522.GE2366@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060123104522.GE2366@marowsky-bree.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2006 at 11:45:22AM +0100, Lars Marowsky-Bree wrote:
> On 2006-01-23T11:38:51, Heinz Mauelshagen <mauelshagen@redhat.com> wrote:
> 
> > > Ok, I still didn't get that. I must be slow.
> > > 
> > > Did you implement some DM-internal stacking now to avoid the above
> > > mentioned complexity? 
> > > 
> > > Otherwise, even DM-on-DM is still stacked via the block device
> > > abstraction...
> > 
> > No, not necessary because a single-level raid4/5 mapping will do it.
> > Ie. it supports <offset> parameters in the constructor as other targets
> > do as well (eg. mirror or linear).
> 
> An dm-md wrapper would not support such a basic feature (which is easily
> added to md too) how?
> 
> I mean, "I'm rewriting it because I want to and because I understand and
> own the code then" is a perfectly legitimate reason

Sure :-)

>, but let's please
> not pretend there's really sound and good technical reasons ;-)

Mind you that there's no need to argue about that:
this is based on requests to do it.

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
