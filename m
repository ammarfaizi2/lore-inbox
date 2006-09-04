Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751388AbWIDKqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbWIDKqe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 06:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWIDKqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 06:46:34 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:51654 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751378AbWIDKqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 06:46:33 -0400
Date: Mon, 4 Sep 2006 12:41:58 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org, viro@ftp.linux.org.uk
Subject: Re: [PATCH 05/22][RFC] Unionfs: Copyup Functionality
In-Reply-To: <20060904092534.GA19836@filer.fsl.cs.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0609041239390.17115@yvahk01.tjqt.qr>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu> <20060901014251.GF5788@fsl.cs.sunysb.edu>
 <Pine.LNX.4.61.0609040852550.9108@yvahk01.tjqt.qr>
 <20060904092534.GA19836@filer.fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Is BUG the right thing, what do others think? (Using WARN, and set err to
>> something useful?)
> 
>Well, it is definitely a condition which Unionfs doesn't expect - if it
>doesn't know about the type, how could it copy it up?

Other filesystems don't seem to BUG either (at least I have not run into 
that yet) when - for whatever reasons - the statdata of a dentry is 
fubared. `ls`  just displays it then, like

 ?-w---Sr-T 1 root root 4294967295 date fubared_file



Jan Engelhardt
-- 

-- 
VGER BF report: H 0
