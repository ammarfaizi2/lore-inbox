Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266187AbUIAPvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266187AbUIAPvA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 11:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267254AbUIAPrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 11:47:51 -0400
Received: from enterprise.spok.net ([213.139.94.155]:46497 "EHLO susi.ggom.de")
	by vger.kernel.org with ESMTP id S267195AbUIAPpd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 11:45:33 -0400
Message-ID: <1094053532.4135ee9c29c2f@secure.frodoid.org>
Date: Wed,  1 Sep 2004 17:45:32 +0200
From: Julien Oster <transcode@mc.frodoid.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Chew <achew@nvidia.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: IDE class driver with SATA controllers
References: <DBFABB80F7FD3143A911F9E6CFD477B03F969B@hqemmail02.nvidia.com> <4135CC6E.3050508@pobox.com>
In-Reply-To: <4135CC6E.3050508@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Originating-IP: 62.225.162.75
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jeff Garzik <jgarzik@pobox.com>:

Hello Jeff,

> With regards to libata being the default, making that an _option_ is 
> feasible, but we will probably default to the IDE driver for quite some 
> time.  There are issues of /dev/hda versus /dev/sda, keeping existing 
> user setups working, etc.

once there is reasonable support to indeed use libata as default,
we could just wrap a pass through IDE driver around, which allocates the
major numbers for /dev/hd* and just feeds everything to libata. Or are the
semantics too different?

Regards,
Julien


-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/
