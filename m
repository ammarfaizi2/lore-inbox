Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267260AbUBSN5Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 08:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267215AbUBSN5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 08:57:24 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:49900 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S267260AbUBSN4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 08:56:00 -0500
X-Sasl-enc: JNkYtjOzDVE7a8hxVWvanQ 1077198438
Subject: Re: ext3 on raid5 failure
From: Leandro =?ISO-8859-1?Q?Guimar=E3es?= Faria Corcete Dutra 
	<leandro@dutra.fastmail.fm>
To: Jan Dittmer <j.dittmer@portrix.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <40346EAD.5010403@portrix.net>
References: <400A5FAA.5030504@portrix.net>
	 <20040118180232.GD1748@srv-lnx2600.matchmail.com>
	 <20040119153005.GA9261@thunk.org>
	 <pan.2004.02.19.02.32.37.90698@dutra.fastmail.fm>
	 <40346EAD.5010403@portrix.net>
Content-Type: text/plain; charset=UTF-8
Organization: =?ISO-8859-1?Q?=20Fam=C3=ADlia?= Sakama Dutra
Message-Id: <1077198600.11696.19.camel@moacir.wlt.com.br>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 19 Feb 2004 10:50:00 -0300
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Qui, 2004-02-19 às 05:07, Jan Dittmer escreveu:
> Leandro Guimarães Faria Corsetti Dutra wrote:
> >>>On Sun, Jan 18, 2004 at 11:27:54AM +0100, Jan Dittmer wrote:
> >>>>EXT3-fs error (device dm-1): ext3_readdir: bad entry in directory
> >>>>#9783034: rec_len % 4 != 0 - offset=0, inode=1846971784,
> >>>>rec_len=33046, name_len=154
> >>>>Aborting journal on device dm-1.
> >>>>ext3_abort called.
> >>>>EXT3-fs abort (device dm-1): ext3_journal_start: Detected aborted
> >>>>journal Remounting filesystem read-only
> > 
> > 	Has this been resolved?  I have a machine due to enter production, am
> > considering going back to 2.4 if there is no further information.
>
> I haven't tried it with 2.6 since this incident. But considering that 
> the machine in question crashed a couple of times afterwards, it may 
> well be, that a hardware fault caused this initially. 

	I don't believe so, because I have already run both memtest86 (all
tests, a dozen passes) and cpuburn (burnP6, several hours).  I am now
trying to figure out how to run fsx-linux, documentation seems scarce.


> But I simply don't 
> dare to put 2.6 again on this machine as I've no real backup of most of 
> the data, and restoring some 100 gb from cds is really annoying.

	That's the position I think I will have to face.  A pity, I was already
hooked into 2.6's speed and LVM2.


-- 
Leandro Guimarães Faria Corcete Dutra
Maringá, PR, BRASIL                 +55 (11) 5685 2219
http://br.geocities.com./lgcdutra/  +55 (44) 3028 7467
Soli Deo Gloria!                    +55 (44) 3028 8335

