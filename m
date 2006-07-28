Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161222AbWG1SVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161222AbWG1SVK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 14:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161221AbWG1SVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 14:21:09 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:57743 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1161219AbWG1SVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 14:21:08 -0400
Subject: Re: [PATCH 1/3] scsi : megaraid_{mm,mbox}: 64-bit DMA capability
	checker
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
Cc: vvs@sw.ru, akpm@osdl.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       "Patro, Sumant" <Sumant.Patro@engenio.com>,
       "Yang, Bo" <Bo.Yang@engenio.com>
In-Reply-To: <890BF3111FB9484E9526987D912B261932E2CF@NAMAIL3.ad.lsil.com>
References: <890BF3111FB9484E9526987D912B261932E2CF@NAMAIL3.ad.lsil.com>
Content-Type: text/plain
Date: Fri, 28 Jul 2006 13:20:54 -0500
Message-Id: <1154110854.9447.41.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-25 at 08:44 -0600, Ju, Seokmann wrote:
> This patch contains 
> - a fix for 64-bit DMA capability check in megaraid_{mm,mbox} driver.
> - includes changes (going back to 32-bit DMA mask if 64-bit DMA mask
> failes) suggested by James with previous patch.
> - addition of SATA 150-4/6 as commented by Vasily Averin.

Warning: trailing whitespace in lines 885,889 of
drivers/scsi/megaraid/megaraid_mbox.c
Warning: trailing whitespace in lines
13,15,16,19,21,22,26,27,29,31,33,37,39,46 of
Documentation/scsi/ChangeLog.megaraid

I'll fix it up this time, but in future could you trailing whitespace
check your patches? (git will do this for you).

Also, when you do a git workflow, the body of the email becomes the
commit message, so things like this

> This is a third patch which follows prevous two patches ([PATCH 1/3]
> and
> [PATCH 2/3]).

while no doubt being useful to the members of linux-scsi who are
actually unable to count aren't actually useful in commit messages.

James


