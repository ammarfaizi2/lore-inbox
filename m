Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264913AbUGCFih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264913AbUGCFih (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 01:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264914AbUGCFig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 01:38:36 -0400
Received: from dci.doncaster.on.ca ([66.11.168.194]:39303 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S264913AbUGCFif (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 01:38:35 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Kevin Corry <kevcorry@us.ibm.com>
Subject: Re: [PATCH] 2/5: Device-mapper: kcopyd
Date: Sat, 3 Jul 2004 01:44:44 -0400
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>,
       Alasdair G Kergon <agk@redhat.com>, Andrew Morton <akpm@osdl.org>
References: <20040602154129.GO6302@agk.surrey.redhat.com> <20040602161541.GB15785@schnapps.adilger.int> <200406021150.48049.kevcorry@us.ibm.com>
In-Reply-To: <200406021150.48049.kevcorry@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407030144.44857.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 June 2004 12:50, Kevin Corry wrote:
> On Wednesday 02 June 2004 11:15 am, Andreas Dilger wrote:
> > It might be nice to have a brief comment here explaining what this is
> > and how it is supposed to be used.
>
> How's this?
>
> We're also working on some general documentation which will go in
> Documentation/device-mapper and will include more detailed information
> about the core driver and the other sub-modules. We'll try to submit those
> patches in the near future.
>
> + * Kcopyd provides a simple interface for copying an area of one
> + * block-device to one or more other block-devices, with an asynchronous
> + * completion notification.

Hi Kevin,

Once again, sorry for the lag.

Since not everybody knows the device-mapper code by heart, I'll add that 
kcopyd is used by the snapshot target to perform copyouts, that is, to 
preserve snapshotted data that would otherwise be overwritten.

Another potential use would be synching in the mirror target.

Regards,

Daniel
