Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265955AbUGUCPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265955AbUGUCPL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 22:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266133AbUGUCPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 22:15:10 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:12501 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S265955AbUGUCPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 22:15:06 -0400
Date: Tue, 20 Jul 2004 21:26:21 -0400
From: Ben Collins <bcollins@debian.org>
To: Moritz Muehlenhoff <jmm@informatik.uni-bremen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Status of IEEE1394 vulnerability in 2.4
Message-ID: <20040721012621.GA10720@phunnypharm.org>
References: <p6q0t1-2a3.ln1@legolas.mmuehlenhoff.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p6q0t1-2a3.ln1@legolas.mmuehlenhoff.de>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2004 at 02:32:57AM +0200, Moritz Muehlenhoff wrote:
> Hi,
> what's the status of the IEEE 1394 vulnerability wrt
> kernel 2.4? [1]
> Will it be fixed in 2.4.27? rc3 is two weeks old and
> there haven't been bitkeeper snapshots since April.

I have yet to fix them. Note that they are NOT as serious as described.
One requires a local user to have access to the devices. Generally this
isn't the default case. The other one requires maliciously changed
firmware in an external device. Not too many people have the know-how and
desire to do this, just to crash your system (they would have better luck
just beating your box with a hammer).

The other bug about allocating huge amounts of memory is just plain wrong,
and is not a bug. It cannot happen.

I'll be fixing things this weekend.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
