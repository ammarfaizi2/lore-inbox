Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266640AbTBXLTz>; Mon, 24 Feb 2003 06:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266735AbTBXLTz>; Mon, 24 Feb 2003 06:19:55 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:29316 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S266640AbTBXLTy>; Mon, 24 Feb 2003 06:19:54 -0500
Date: Mon, 24 Feb 2003 12:30:02 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with IDE-SCSI in 2.4.21-pre4/2.4.20
Message-ID: <20030224113002.GC27646@louise.pinerecords.com>
References: <20030224122259.7a468c82.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030224122259.7a468c82.skraw@ithnet.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [skraw@ithnet.com]
> 
> I tried simple "mount /dev/sr0 /mnt" -> spinup, then freeze, "mount /dev/scd0
> /mnt" -> spinup, then freeze. I even tried attaching a real SCSI cdrom, which
> works as expected. I tried booting a live filesystem directly from the
> questionable drive, it works (obviously does not use ide-scsi, but atapi).

lspci -vv
?

Also try 2.4.21-pre4-ac6 (which contains the latest and greatest IDE code).

-- 
Tomas Szepe <szepe@pinerecords.com>
