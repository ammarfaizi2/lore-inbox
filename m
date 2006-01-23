Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932451AbWAWKqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbWAWKqP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 05:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbWAWKqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 05:46:15 -0500
Received: from gate.in-addr.de ([212.8.193.158]:60806 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S932451AbWAWKqO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 05:46:14 -0500
Date: Mon, 23 Jan 2006 11:45:22 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Heinz Mauelshagen <mauelshagen@redhat.com>
Cc: Neil Brown <neilb@suse.de>, Phillip Susi <psusi@cfl.rr.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       "Lincoln Dale (ltd)" <ltd@cisco.com>, Michael Tokarev <mjt@tls.msk.ru>,
       linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: [PATCH 000 of 5] md: Introduction
Message-ID: <20060123104522.GE2366@marowsky-bree.de>
References: <17360.9233.215291.380922@cse.unsw.edu.au> <20060120183621.GA2799@redhat.com> <20060120225724.GW22163@marowsky-bree.de> <20060121000142.GR2801@redhat.com> <20060121000344.GY22163@marowsky-bree.de> <20060121000806.GT2801@redhat.com> <20060121001311.GA22163@marowsky-bree.de> <20060123094418.GX2801@redhat.com> <20060123102601.GD2366@marowsky-bree.de> <20060123103851.GY2801@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060123103851.GY2801@redhat.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-01-23T11:38:51, Heinz Mauelshagen <mauelshagen@redhat.com> wrote:

> > Ok, I still didn't get that. I must be slow.
> > 
> > Did you implement some DM-internal stacking now to avoid the above
> > mentioned complexity? 
> > 
> > Otherwise, even DM-on-DM is still stacked via the block device
> > abstraction...
> 
> No, not necessary because a single-level raid4/5 mapping will do it.
> Ie. it supports <offset> parameters in the constructor as other targets
> do as well (eg. mirror or linear).

An dm-md wrapper would not support such a basic feature (which is easily
added to md too) how?

I mean, "I'm rewriting it because I want to and because I understand and
own the code then" is a perfectly legitimate reason, but let's please
not pretend there's really sound and good technical reasons ;-)


Sincerely,
    Lars Marowsky-Brée

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

