Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbULVPOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbULVPOk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 10:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbULVPOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 10:14:39 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:44171 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261252AbULVPOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 10:14:38 -0500
Subject: Re: [2.6 patch] ieee1394_core.c: remove unneeded EXPORT_SYMBOL's
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Lee Revell <rlrevell@joe-job.com>, Greg KH <greg@kroah.com>,
       Adrian Bunk <bunk@stusta.de>, Dan Dennedy <dan@dennedy.org>,
       Ben Collins <bcollins@debian.org>,
       Linux1394-Devel <linux1394-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041221221924.GA12709@thunk.org>
References: <20041220015320.GO21288@stusta.de>
	 <1103508610.3724.69.camel@kino.dennedy.org>
	 <20041220022503.GT21288@stusta.de>
	 <1103510535.1252.18.camel@krustophenia.net>
	 <1103516870.3724.103.camel@kino.dennedy.org>
	 <20041220225324.GY21288@stusta.de>
	 <1103583486.1252.102.camel@krustophenia.net>
	 <20041221171702.GE1459@kroah.com>
	 <1103649633.9220.12.camel@krustophenia.net>
	 <20041221221924.GA12709@thunk.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1103724502.8250.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 22 Dec 2004 14:08:23 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-12-21 at 22:19, Theodore Ts'o wrote:
> > Yeah but I hope you can understand why someone would be hesitant to
> > submit a broken driver.  It just makes the author look bad.  I would not
> > feel right submitting something that didn't work.
> 
> That's what CONFIG_EXPERIMENTAL is for....

If the symbols are not there then this doesn't help vendors wanting to
produce GPL drivers because people have to rebuild entire kernels not
just add a driver. 

You are also ignoring the cultural issues and personal preferences that
lead some users not to submit code until it passes some quality level.
This is common in both businesses and individuals and you see it
regularly.

Alan

