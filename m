Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264706AbTBXMdR>; Mon, 24 Feb 2003 07:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264844AbTBXMdR>; Mon, 24 Feb 2003 07:33:17 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:38788 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S264706AbTBXMdQ>; Mon, 24 Feb 2003 07:33:16 -0500
Date: Mon, 24 Feb 2003 13:43:17 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with IDE-SCSI in 2.4.21-pre4/2.4.20
Message-ID: <20030224124317.GD27646@louise.pinerecords.com>
References: <20030224122259.7a468c82.skraw@ithnet.com> <20030224113002.GC27646@louise.pinerecords.com> <20030224132909.068d0ce9.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030224132909.068d0ce9.skraw@ithnet.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [skraw@ithnet.com]
> 
> On Mon, 24 Feb 2003 12:30:02 +0100
> Tomas Szepe <szepe@pinerecords.com> wrote:
> 
> > > [skraw@ithnet.com]
> > > 
> > > I tried simple "mount /dev/sr0 /mnt" -> spinup, then freeze, "mount /dev/scd0
> > > /mnt" -> spinup, then freeze. I even tried attaching a real SCSI cdrom, which
> > > works as expected. I tried booting a live filesystem directly from the
> > > questionable drive, it works (obviously does not use ide-scsi, but atapi).
> > 
> > lspci -vv
> > ?

Serverworks.  Well, you definitely want to try -ac.  :)

-- 
Tomas Szepe <szepe@pinerecords.com>
