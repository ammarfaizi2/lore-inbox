Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbVIOI1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbVIOI1v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 04:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbVIOI1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 04:27:51 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:48296 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932096AbVIOI1v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 04:27:51 -0400
Subject: Re: [patch 1/7] s390: default configuration.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050914221650.0e5b8e49.akpm@osdl.org>
References: <20050914155308.GA27169@skybase.boeblingen.de.ibm.com>
	 <20050914221650.0e5b8e49.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 15 Sep 2005 10:27:53 +0200
Message-Id: <1126772873.4900.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-14 at 22:16 -0700, Andrew Morton wrote:
> I'd propose that these:
> 
> s390-default-configuration.patch
> s390-bl_dev-array-size.patch
> s390-crypto-driver-patch-take-2.patch
> s390-show_cpuinfo-fix.patch
> s390-diag-0x308-reipl.patch
> 
> are 2.6.14 material whereas these:
> 
> s390-3270-fullscreen-view.patch
> s390-ipl-device.patch
> 
> aren't (at least, yet).  I've asked Greg to take a look at the sysfs stuff
> in the last two patches.
> 
> OK?

Whatever you think is best. The 3270 patch is largeish and the
ipl-device patch introduces a new sysfs interface. Both are good reasons
for not including them into 2.6.14.

-- 
blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH


