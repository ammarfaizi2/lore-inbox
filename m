Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264405AbUE3VOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264405AbUE3VOv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 17:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264411AbUE3VOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 17:14:51 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5035 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264405AbUE3VOt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 17:14:49 -0400
Date: Sun, 30 May 2004 22:14:48 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Andreas Schwab <schwab@suse.de>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjanv@redhat.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.x partition breakage and dual booting
Message-ID: <20040530211448.GD12308@parcelfarce.linux.theplanet.co.uk>
References: <40BA2213.1090209@pobox.com> <20040530183609.GB5927@pclin040.win.tue.nl> <40BA2E5E.6090603@pobox.com> <20040530200300.GA4681@apps.cwi.nl> <20040530204715.GB12308@parcelfarce.linux.theplanet.co.uk> <jeu0xxzkqc.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jeu0xxzkqc.fsf@sykes.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2004 at 11:08:27PM +0200, Andreas Schwab wrote:
> viro@parcelfarce.linux.theplanet.co.uk writes:
> 
> > On Sun, May 30, 2004 at 10:03:00PM +0200, Andries Brouwer wrote:
> >> Clearly, BLKGETSIZE is obsolescent - it should be replaced by
> >> BLKGETSIZE64 everywhere. 2^41 B is 2 TB, and some RAIDs are larger.
> >
> > ITYM "it should be replaced to lseek(fd, SEEK_END, 0) everywhere".
> ITYM                             lseek(fd, 0, SEEK_END)

Sorry, braino.
