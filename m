Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbWH3OAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWH3OAV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 10:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbWH3OAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 10:00:20 -0400
Received: from bayc1-pasmtp01.bayc1.hotmail.com ([65.54.191.161]:51491 "EHLO
	bayc1-pasmtp01.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1750762AbWH3OAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 10:00:19 -0400
Message-ID: <BAYC1-PASMTP01E922231EF198D3EF563EAE3E0@CEZ.ICE>
X-Originating-IP: [65.94.249.130]
X-Originating-Email: [seanlkml@sympatico.ca]
Date: Wed, 30 Aug 2006 10:00:15 -0400
From: Sean <seanlkml@sympatico.ca>
To: Willy Tarreau <w@1wt.eu>
Cc: Andi Kleen <ak@suse.de>, davej@redhat.com, pageexec@freemail.hu,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] exception processing in early boot
Message-Id: <20060830100015.6b967c32.seanlkml@sympatico.ca>
In-Reply-To: <20060830131612.GB351@1wt.eu>
References: <20060830063932.GB289@1wt.eu>
	<p73y7t65z6c.fsf@verdi.suse.de>
	<20060830121845.GA351@1wt.eu>
	<200608301459.15008.ak@suse.de>
	<20060830131612.GB351@1wt.eu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.10.1; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Aug 2006 14:00:18.0686 (UTC) FILETIME=[A057F1E0:01C6CC3C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2006 15:16:12 +0200
Willy Tarreau <w@1wt.eu> wrote:

> That's already what I'm doing, and yes, it is *that* hard. We're literally
> speaking about *thousands* of patches. It's as difficult to find one patch
> within 2.6 git changes as it is to find a useful mail in the middle of 99%
> spam. This is not because of GIT but because of the number of changes.

Willy,

The git-cherry command might be useful for you in this situation.  It will
show you all the patches in one branch that have been merged in an upstream
branch, and those that haven't.  Not sure if it's perfect for your situation,
but may be worth a look.

Sean
