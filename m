Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264402AbUE3VKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264402AbUE3VKK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 17:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264405AbUE3VKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 17:10:09 -0400
Received: from cantor.suse.de ([195.135.220.2]:39069 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264402AbUE3VIa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 17:08:30 -0400
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjanv@redhat.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.x partition breakage and dual booting
References: <40BA2213.1090209@pobox.com>
	<20040530183609.GB5927@pclin040.win.tue.nl>
	<40BA2E5E.6090603@pobox.com> <20040530200300.GA4681@apps.cwi.nl>
	<20040530204715.GB12308@parcelfarce.linux.theplanet.co.uk>
From: Andreas Schwab <schwab@suse.de>
X-Yow: ..  I'm IMAGINING a sensuous GIRAFFE, CAVORTING in the BACK ROOM
 of a KOSHER DELI --
Date: Sun, 30 May 2004 23:08:27 +0200
In-Reply-To: <20040530204715.GB12308@parcelfarce.linux.theplanet.co.uk> (viro@parcelfarce.linux.theplanet.co.uk's
 message of "Sun, 30 May 2004 21:47:15 +0100")
Message-ID: <jeu0xxzkqc.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk writes:

> On Sun, May 30, 2004 at 10:03:00PM +0200, Andries Brouwer wrote:
>> Clearly, BLKGETSIZE is obsolescent - it should be replaced by
>> BLKGETSIZE64 everywhere. 2^41 B is 2 TB, and some RAIDs are larger.
>
> ITYM "it should be replaced to lseek(fd, SEEK_END, 0) everywhere".
ITYM                             lseek(fd, 0, SEEK_END)

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
