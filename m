Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262124AbVCAXqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262124AbVCAXqq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 18:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbVCAXqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 18:46:45 -0500
Received: from ns.suse.de ([195.135.220.2]:3232 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262129AbVCAXqY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 18:46:24 -0500
To: Bernd Schubert <bernd-schubert@web.de>
Cc: Andi Kleen <ak@muc.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       nfs@lists.sourceforge.net
Subject: Re: x86_64: 32bit emulation problems
References: <200502282154.08009.bernd.schubert@pci.uni-heidelberg.de>
	<200503012207.02915.bernd-schubert@web.de>
	<jewtsruie9.fsf@sykes.suse.de>
	<200503020019.20256.bernd-schubert@web.de>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Hello, GORRY-O!!  I'm a GENIUS from HARVARD!!
Date: Wed, 02 Mar 2005 00:46:23 +0100
In-Reply-To: <200503020019.20256.bernd-schubert@web.de> (Bernd Schubert's
 message of "Wed, 2 Mar 2005 00:19:19 +0100")
Message-ID: <jebra3udyo.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Schubert <bernd-schubert@web.de> writes:

> Hmm, after compiling with -D_FILE_OFFSET_BITS=64 it works fine. But why does 
> it work without this option on a 32bit kernel, but not on a 64bit kernel?

See nfs_fileid_to_ino_t for why the inode number is different between
32bit and 64bit kernels.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
