Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130381AbRCLOWx>; Mon, 12 Mar 2001 09:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130392AbRCLOWo>; Mon, 12 Mar 2001 09:22:44 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:13586 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130383AbRCLOWg>; Mon, 12 Mar 2001 09:22:36 -0500
Subject: Re: Rename all derived CONFIG variables
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Mon, 12 Mar 2001 14:24:28 +0000 (GMT)
Cc: kaos@ocs.com.au (Keith Owens), linux-kernel@vger.kernel.org,
        elenstev@mesatop.com, kbuild-devel@lists.sourceforge.net,
        alan@redhat.com (Alan Cox)
In-Reply-To: <3AAC79D1.F9837EE7@mandrakesoft.com> from "Jeff Garzik" at Mar 12, 2001 02:25:05 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14cTFP-0001yS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Not only do I think that CONFIG_xxx_DERIVED needlessly extends the name
> of derived vars, but your patch does not belong in a stable series. 
> Derived CONFIG_xxx vars are likely to be referenced in source.  Changing
> those vars in the middle of a stable series pointlessly breaks external
> source code.
> 
> I hope vendors don't start applying this patch...

I dont see them doing that. I'm not going to be applying it for -ac either.
It would appear that this is a wrong way to fix the problem.

The config option checker should be scanning for define_*** options and
removing them from its output

