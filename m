Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261543AbVBXQii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbVBXQii (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 11:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262411AbVBXQih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 11:38:37 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:56496 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S262420AbVBXQiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 11:38:17 -0500
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: Greg Freemyer <greg.freemyer@gmail.com>
Subject: Re: [patch ide-dev 3/9] merge LBA28 and LBA48 Host Protected Area support code
Date: Thu, 24 Feb 2005 17:30:55 +0100
User-Agent: KMail/1.7.1
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Tejun Heo <htejun@gmail.com>
References: <Pine.GSO.4.58.0502241539100.13534@mion.elka.pw.edu.pl> <87f94c370502240810583e3a4a@mail.gmail.com>
In-Reply-To: <87f94c370502240810583e3a4a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502241730.56015.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 February 2005 17:10, Greg Freemyer wrote:
> I have generic question about HPA, not the patch.
> 
> I have noticed with a SUSE 2.6.8 vendor kernel, the HPA behavior is
> not consistent.

Please retry with vanilla kernel.

> ie. With exactly the same computer/controller, but with different disk
> drives (models/manufacturers) the HPA behavior varies.
> 
> In all my testing the HPA was always properly detected, but sometimes
> the max_address is set to the native_max_address during bootup and
> sometimes it is not.

Please be more precise.

What do you mean by 'sometimes'?

What are the exact differences between machines?

Are there any differences in software configurations
(i.e. kernel parameters) between this machines?

> Is there some reason for this behavior or is one case or the other a bug?

Dunno, not enough info.

> Does this patch somehow address the inconsistency?

No.

> Am I right in assuming this behavior also exists in the vanilla
> kernels?.  ie. I doubt that vendors are patching this behavior.

Recent vanilla kernels always set maximum available capacity.
