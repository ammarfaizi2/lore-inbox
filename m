Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262116AbVCAXWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbVCAXWN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 18:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbVCAXWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 18:22:12 -0500
Received: from news.suse.de ([195.135.220.2]:1937 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262114AbVCAXWG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 18:22:06 -0500
To: Andi Kleen <ak@muc.de>
Cc: Bernd Schubert <bernd-schubert@web.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       nfs@lists.sourceforge.net
Subject: Re: x86_64: 32bit emulation problems
References: <200502282154.08009.bernd.schubert@pci.uni-heidelberg.de>
	<20050301202417.GA40466@muc.de>
	<200503012207.02915.bernd-schubert@web.de>
	<jewtsruie9.fsf@sykes.suse.de> <20050301221902.GA73844@muc.de>
From: Andreas Schwab <schwab@suse.de>
X-Yow: My DIGITAL WATCH has an automatic SNOOZE FEATURE!!
Date: Wed, 02 Mar 2005 00:22:05 +0100
In-Reply-To: <20050301221902.GA73844@muc.de> (Andi Kleen's message of "1 Mar
 2005 23:19:02 +0100, Tue, 1 Mar 2005 23:19:02 +0100")
Message-ID: <jek6oruf36.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> writes:

> On Tue, Mar 01, 2005 at 11:10:38PM +0100, Andreas Schwab wrote:
>> That's because there are some values in the stat64 buffer delivered by the
>> kernel which cannot be packed into the stat buffer that you pass to stat.
>> Use stat64 or _FILE_OFFSET_BITS=64.
>
> If that had been the case strace would have reported EOVERFLOW
> or E2BIG.

No, the values are ok for stat64.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
