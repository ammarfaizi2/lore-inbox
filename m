Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270593AbTGTBwl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 21:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270594AbTGTBwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 21:52:41 -0400
Received: from cm61.gamma179.maxonline.com.sg ([202.156.179.61]:42764 "EHLO
	amaryllis.anomalistic.org") by vger.kernel.org with ESMTP
	id S270593AbTGTBwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 21:52:40 -0400
Date: Sun, 20 Jul 2003 10:07:34 +0800
From: Eugene Teo <eugene.teo@eugeneteo.net>
To: Walter Harms <WHarms@bfs.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bug alpha configure linux-2.6.0-test1
Message-ID: <20030720020734.GA16983@eugeneteo.net>
Reply-To: Eugene Teo <eugene.teo@eugeneteo.net>
References: <vines.sxdD+KAO4zA@SZKOM.BFS.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vines.sxdD+KAO4zA@SZKOM.BFS.DE>
X-Operating-System: Linux 2.2.20
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perhaps you might want to first copy your dotconfig
to /path/to/linux-version/ then run make menuconfig,
then save it, then compile it. 

> boolean symbol BINFMT_ZFLAT tested for 'm'? test forced to 'n'

This means that it is a new boolean symbol that your
config don't have.

> arch/alpha/defconfig:244: trying to assign nonexistent symbol SCSI_NCR53C8XX

I believe this is a symbol that exists in your config
but the kernel doesn't have this in the menu anymore.

Eugene

> hope that helps
> walter
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
