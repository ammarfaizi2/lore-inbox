Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132483AbRCZRaD>; Mon, 26 Mar 2001 12:30:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132482AbRCZR3y>; Mon, 26 Mar 2001 12:29:54 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:62477 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132502AbRCZR3h>; Mon, 26 Mar 2001 12:29:37 -0500
Subject: Re: ext2 corruption in 2.4.2, scsi only system
To: dmartin@cliftonlabs.com (Dale E Martin)
Date: Mon, 26 Mar 2001 18:30:59 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <20010326120155.A31414@clifton-labs.com> from "Dale E Martin" at Mar 26, 2001 12:01:55 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14hapa-000223-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> After scanning the mailing list archives, I was under the impression that
> this Buslogic issue was an AC series problem.  Is there a known problem
> with Buslogic controllers in 2.4.2?  

It seems there is. The changes in -ac and in 2.4.3pre limit the max blocks
per request which seems to make it happier

