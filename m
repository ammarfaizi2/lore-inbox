Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131336AbRCNTNS>; Wed, 14 Mar 2001 14:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131404AbRCNTNH>; Wed, 14 Mar 2001 14:13:07 -0500
Received: from h00059aa0e40d.ne.mediaone.net ([66.31.89.164]:33526 "EHLO
	flowers.house.larsshack.org") by vger.kernel.org with ESMTP
	id <S131336AbRCNTND>; Wed, 14 Mar 2001 14:13:03 -0500
Date: Wed, 14 Mar 2001 14:11:57 -0500 (EST)
From: Lars Kellogg-Stedman <lars@larsshack.org>
To: Christoph Hellwig <hch@caldera.de>
cc: John Jasen <jjasen1@umbc.edu>, <linux-kernel@vger.kernel.org>,
        AmNet Computers <amnet@amnet-comp.com>
Subject: Re: magic device renumbering was -- Re: Linux 2.4.2ac20
In-Reply-To: <200103141823.TAA11310@ns.caldera.de>
Message-ID: <Pine.LNX.4.30.0103141410360.2004-100000@flowers.house.larsshack.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Put LABEL=<label set with e2label> in you fstab in place of the device name.

Which is great, for filesystems that support labels.  Unfortunately,
this isn't universally available -- for instance, you cannot mount
a swap partition by label or uuid, so it is not possible to completely
isolate yourself from the problems of disk device renumbering.

-- Lars

-- 
Lars Kellogg-Stedman <lars@larsshack.org>

