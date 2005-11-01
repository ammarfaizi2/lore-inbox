Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750949AbVKARA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbVKARA7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 12:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750958AbVKARA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 12:00:59 -0500
Received: from ns.suse.de ([195.135.220.2]:42373 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750949AbVKARA6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 12:00:58 -0500
From: Andreas Schwab <schwab@suse.de>
To: Jan Niehusmann <jan@gondor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 corruption: "JBD: no valid journal superblock found"
References: <20051101134232.GA9234@knautsch.gondor.com>
	<20051101135123.GB9234@knautsch.gondor.com>
X-Yow: I didn't order any WOO-WOO...  Maybe a YUBBA..  But no WOO-WOO!
Date: Tue, 01 Nov 2005 18:00:53 +0100
In-Reply-To: <20051101135123.GB9234@knautsch.gondor.com> (Jan Niehusmann's
	message of "Tue, 1 Nov 2005 14:51:23 +0100")
Message-ID: <jell08qp4q.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Niehusmann <jan@gondor.com> writes:

> On Tue, Nov 01, 2005 at 02:42:33PM +0100, Jan Niehusmann wrote:
>> Currently, I'm experiencing a strange problem with one of my ext3
>> filesystems: There seems to be some journal corruption, but up to now I
>
> Well, of course I forgot one important detail: The kernel version. This
> is a 2.6.14

I'm also experiencing ext3 corruptions with 2.6.14:

Oct 29 17:46:08 igel kernel: EXT3-fs error (device sda7): ext3_free_inode: bit already cleared for inode 482170
Oct 29 17:46:08 igel kernel: Aborting journal on device sda7.
Oct 29 17:46:08 igel kernel: ext3_abort called.
Oct 29 17:46:08 igel kernel: EXT3-fs error (device sda7): ext3_journal_start_sb: Detected aborted journal
Oct 29 17:46:08 igel kernel: Remounting filesystem read-only
Oct 29 17:46:08 igel kernel: EXT3-fs error (device sda7) in ext3_delete_inode: IO failure

2.6.14-rc5 has been rock solid so far (running on PowerMac G5).

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
