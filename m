Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932452AbWIDHeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbWIDHeo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 03:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbWIDHeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 03:34:44 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:39108 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932438AbWIDHen (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 03:34:43 -0400
Date: Mon, 4 Sep 2006 09:30:48 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Josef Sipek <jsipek@cs.sunysb.edu>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org, viro@ftp.linux.org.uk
Subject: Re: [PATCH 13/22][RFC] Unionfs: Readdir state
In-Reply-To: <20060901015345.GN5788@fsl.cs.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0609040928550.9108@yvahk01.tjqt.qr>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu> <20060901015345.GN5788@fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


{} as usual.

>+	/* If we print entry, we end up with spurious data. */
>+	/* print_entry("name = %*s", namelen, name); */

%.*s

>+		new->name = (char *)kmalloc(namelen + 1, GFP_KERNEL);

Nocast.




Jan Engelhardt
-- 

-- 
VGER BF report: H 0
