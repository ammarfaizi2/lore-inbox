Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131530AbRCNUCh>; Wed, 14 Mar 2001 15:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131531AbRCNUC1>; Wed, 14 Mar 2001 15:02:27 -0500
Received: from ns.caldera.de ([212.34.180.1]:7942 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S131530AbRCNUCS>;
	Wed, 14 Mar 2001 15:02:18 -0500
Date: Wed, 14 Mar 2001 21:01:01 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Lars Kellogg-Stedman <lars@larsshack.org>
Cc: Christoph Hellwig <hch@caldera.de>, John Jasen <jjasen1@umbc.edu>,
        linux-kernel@vger.kernel.org, AmNet Computers <amnet@amnet-comp.com>
Subject: Re: magic device renumbering was -- Re: Linux 2.4.2ac20
Message-ID: <20010314210101.B19588@caldera.de>
Mail-Followup-To: Lars Kellogg-Stedman <lars@larsshack.org>,
	John Jasen <jjasen1@umbc.edu>, linux-kernel@vger.kernel.org,
	AmNet Computers <amnet@amnet-comp.com>
In-Reply-To: <200103141823.TAA11310@ns.caldera.de> <Pine.LNX.4.30.0103141410360.2004-100000@flowers.house.larsshack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.4.30.0103141410360.2004-100000@flowers.house.larsshack.org>; from lars@larsshack.org on Wed, Mar 14, 2001 at 02:11:57PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2001 at 02:11:57PM -0500, Lars Kellogg-Stedman wrote:
> > Put LABEL=<label set with e2label> in you fstab in place of the device name.
> 
> Which is great, for filesystems that support labels.  Unfortunately,
> this isn't universally available -- for instance, you cannot mount
> a swap partition by label or uuid, so it is not possible to completely
> isolate yourself from the problems of disk device renumbering.

True.  Let's mark for 2.5 ToDO list: magic number for swap...

Just because it does not work universally it doesn't have to be a bad idea...

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
