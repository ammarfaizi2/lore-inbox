Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbVCWWUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbVCWWUG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 17:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbVCWWUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 17:20:05 -0500
Received: from mx1.suse.de ([195.135.220.2]:16037 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261474AbVCWWTj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 17:19:39 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: "Luck, Tony" <tony.luck@intel.com>, "Hugh Dickins" <hugh@veritas.com>,
       "Nick Piggin" <nickpiggin@yahoo.com.au>, <akpm@osdl.org>,
       <davem@davemloft.net>, <benh@kernel.crashing.org>, <ak@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] freepgt: free_pgtables use vma list
References: <B8E391BBE9FE384DAA4C5C003888BE6F0324516D@scsmsx401.amr.corp.intel.com>
	<16961.59549.946004.551974@cargo.ozlabs.ibm.com>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Somewhere in DOWNTOWN BURBANK a prostitute is OVERCOOKING a LAMB
 CHOP!!
Date: Wed, 23 Mar 2005 23:19:28 +0100
In-Reply-To: <16961.59549.946004.551974@cargo.ozlabs.ibm.com> (Paul
 Mackerras's message of "Thu, 24 Mar 2005 09:07:25 +1100")
Message-ID: <jevf7ic8en.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras <paulus@samba.org> writes:

> Luck, Tony writes:
>
>> Can we legislate that "end==0" isn't possible.
>
> I think this is only likely to be a problem on 32-bit platforms with
> hardware support for separate user and kernel address spaces.  m68k
> and sparc32 come to mind, though I might be mistaken.

On m68k we don't allow addresses above 0xF0000000.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
