Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312285AbSCUORV>; Thu, 21 Mar 2002 09:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312233AbSCUORG>; Thu, 21 Mar 2002 09:17:06 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:53000 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312213AbSCUOQv>; Thu, 21 Mar 2002 09:16:51 -0500
Subject: Re: 2 questions about SCSI initialization
To: dougg@torque.net (Douglas Gilbert)
Date: Thu, 21 Mar 2002 14:32:26 +0000 (GMT)
Cc: zaitcev@redhat.com (Pete Zaitcev), linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <3C99E6C7.34F05AE7@torque.net> from "Douglas Gilbert" at Mar 21, 2002 08:57:27 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16o3cA-0005KA-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> for using its own memory management ( scsi_malloc() )
> or the most conservative mm calls. GFP_ATOMIC may well
> be overkill in scsi_build_commandblocks(). However it

(Historically the scsi layer predates kmalloc in Linux so had to use its
 own allocator)
