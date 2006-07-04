Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbWGDOqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbWGDOqA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 10:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWGDOqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 10:46:00 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:52949 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932262AbWGDOp7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 10:45:59 -0400
Date: Tue, 4 Jul 2006 16:45:42 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Diego Calleja <diegocg@gmail.com>,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>, arjan@infradead.org,
       zdzichu@irc.pl, helgehaf@aitel.hist.no, sithglan@stud.uni-erlangen.de,
       tytso@mit.edu, linux-kernel@vger.kernel.org
Subject: Re: ext4 features
In-Reply-To: <1151965033.16528.28.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0607041643470.4190@yvahk01.tjqt.qr>
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de> 
 <20060701170729.GB8763@irc.pl>  <20060701174716.GC24570@cip.informatik.uni-erlangen.de>
  <20060701181702.GC8763@irc.pl> <20060703202219.GA9707@aitel.hist.no> 
 <20060703205523.GA17122@irc.pl>  <1151960503.3108.55.camel@laptopd505.fenrus.org>
  <44A9904F.7060207@wolfmountaingroup.com>  <20060703232547.2d54ab9b.diegocg@gmail.com>
 <1151965033.16528.28.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>There are some big problems with "deleted" however and doing it in
>kernel space. A lot of programs just overwrite data. You would have to
>look for things like O_TRUNC on a file open and ftruncate.
>
At least I only want deleted files to be saved, not truncated. The way 
the MSWIN (the gui parts) do it is enough for most users.


Jan Engelhardt
-- 
