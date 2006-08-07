Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbWHGOGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWHGOGE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 10:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbWHGOGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 10:06:04 -0400
Received: from mx1.suse.de ([195.135.220.2]:57740 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932099AbWHGOGD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 10:06:03 -0400
To: Andy Whitcroft <apw@shadowen.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: x86_64 command line truncated
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
	<44D742DD.6090004@shadowen.org>
From: Andi Kleen <ak@suse.de>
Date: 07 Aug 2006 16:05:55 +0200
In-Reply-To: <44D742DD.6090004@shadowen.org>
Message-ID: <p73wt9kprng.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft <apw@shadowen.org> writes:

> It seems that the command line on x86_64 is being truncated during boot:

in mm right?
> Will try and track it down.

Don't bother, it is likely "early-param" (the patch from
hell). I'll investigate.

-Andi
