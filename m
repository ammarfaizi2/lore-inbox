Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbTJXPVF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 11:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262310AbTJXPVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 11:21:05 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:4101 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262306AbTJXPVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 11:21:02 -0400
Subject: Re: [PATCH]  2.4.23-pre8 driver udpate for MPT Fusion (2.05.10)
From: James Bottomley <James.Bottomley@steeleye.com>
To: "Moore, Eric Dean" <emoore@lsil.com>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E57035A944F@exa-atlanta.se.lsil.com>
References: <0E3FA95632D6D047BA649F95DAB60E57035A944F@exa-atlanta.se.lsil.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 24 Oct 2003 11:20:59 -0400
Message-Id: <1067008859.2109.18.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-10-24 at 10:53, Moore, Eric Dean wrote:
> Here's a patch for 2.4.23-pre8 kernel for MPT Fusion driver, coming from LSI
> Logic.
> 
> This patch is large, so I have placed it on the LSI ftp site at:
> ftp://ftp.lsil.com/HostAdapterDrivers/linux/Fusion-MPT/2.05.10/mptlinux-2.05
> .10.patch
> 
> A new email address is setup for directing any MPT Fusion questions:
> mpt_linux_developer@lsil.com

The policy for driver updates into 2.4 is that they should be backports
from 2.6 (for things like mpt fusion that have similar drivers) so that
the newer driver gets into 2.6 first.  If you want to send the 2.6
patches, I can queue them up for when the "bugfix only" freeze is
relaxed.

James


