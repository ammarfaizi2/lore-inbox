Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751850AbWIRRWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbWIRRWz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 13:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751852AbWIRRWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 13:22:55 -0400
Received: from ns2.suse.de ([195.135.220.15]:3000 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751850AbWIRRWz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 13:22:55 -0400
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, yogyas@gmail.com
Subject: Re: How much kernel memory is in 64-bit OS ?
References: <b681c62b0609160434g6ccbbaa0vd0cd68958696726e@mail.gmail.com>
	<b681c62b0609180251m79071e59oe212b1133bf6944c@mail.gmail.com>
	<450EA198.5060302@aitel.hist.no>
From: Andi Kleen <ak@suse.de>
Date: 18 Sep 2006 19:22:52 +0200
In-Reply-To: <450EA198.5060302@aitel.hist.no>
Message-ID: <p7364fl3x8z.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting <helge.hafting@aitel.hist.no> writes:

> The requirement for using a 4G/4G split is to have a processor
> that support 64-bit adressing as well as 32-bit backward compatibility.

s/64/36/. But it's actually not true: 4/4 works on 32bit phys non PAE 
system too (iirc Fedora forced it for some time even on unsuspecting
P-M/VIA C3/586 users who only do 32bit).

> > 2) how it is managed ?
> The kernel runs in 64-bit mode, offering the 4G/4G stuff for 32-bit
> processes.

No.

> 
> > 3) how HIGH_MEMORY concept is related here.
> high memory is a quirky way of supporting more than 4G on a 32-bit

More than ~900MB with a default split.

-Andi
