Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264860AbRGELbR>; Thu, 5 Jul 2001 07:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264885AbRGELbH>; Thu, 5 Jul 2001 07:31:07 -0400
Received: from zeus.kernel.org ([209.10.41.242]:1492 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S264860AbRGELa7>;
	Thu, 5 Jul 2001 07:30:59 -0400
From: bvermeul@devel.blackstar.nl
Date: Thu, 5 Jul 2001 09:46:45 +0200 (CEST)
To: Ingo <tischer@mathematik.uni-ulm.de>
cc: <linux-kernel@vger.kernel.org>, <kuemmel@mathematik.uni-ulm.de>
Subject: Re: Initio 9100 Driver for Linux
In-Reply-To: <Pine.LNX.4.21.0107040726160.2724-200000@nase.athome.langenau.de>
Message-ID: <Pine.LNX.4.33.0107050942320.3524-100000@devel.blackstar.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

> I have a problem with the driver for Initio SCSI Controller 9100 SCSI,
> a dual channel UW SCSI-Controller. On checking the SCSI bus the systems
> has problems to initialize the CD-RW Sanyo (aka Brainwave) BP4-N SCSI
> The CD-RW has SCSI-ID 6 on the second Controller. It is shown on
> system startup an GENERIC CRD-BP4
>
> I had this problem both with Kernel 2.2.17 and 2.2.19.

Check your termination. The initio drivers are very sensitive to
termination errors (use active if possible), and make sure you follow all
the normal rules regarding scsi.

Most problems I've seen are caused by lousy termination, or using three
way busses. I've also seen some problems with some cd writers (Yamaha to
be exact), that I haven't been able to solve yet.

Regards,

Bas Vermeulen

-- 
"God, root, what is difference?"
	-- Pitr, User Friendly

"God is more forgiving."
	-- Dave Aronson

