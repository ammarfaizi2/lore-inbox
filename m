Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262497AbUKDXr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbUKDXr7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 18:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbUKDXr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 18:47:59 -0500
Received: from cantor.suse.de ([195.135.220.2]:26563 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262497AbUKDXr5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 18:47:57 -0500
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fix initcall_debug on ppc64/ia64
References: <20041102195130.GA13589@suse.de>
	<20041103152628.19753cf2.akpm@osdl.org>
	<20041104210547.GA16238@suse.de>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Let's go to CHURCH!
Date: Fri, 05 Nov 2004 00:47:07 +0100
In-Reply-To: <20041104210547.GA16238@suse.de> (Olaf Hering's message of
 "Thu, 4 Nov 2004 22:05:47 +0100")
Message-ID: <je8y9hrxc4.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering <olh@suse.de> writes:

>  On Wed, Nov 03, Andrew Morton wrote:
>
>> Olaf Hering <olh@suse.de> wrote:
>> >
>> > Is a patch like that acceptable (for mainline)? Currently only the
>> > descriptor is printed, not the function itself. Another redirection is
>> > needed.
>> 
>> Is this acked by Paul and Anton?  If so, I'll replace __powerpc64__ with
>> CONFIG_PPC64 and run with it.
>
>
> I guess we need something like this.
> Just where to put it, how to name it and how to handle ia64:

The ia64 version should be identical.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
