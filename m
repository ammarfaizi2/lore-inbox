Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316951AbSE1VDe>; Tue, 28 May 2002 17:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316954AbSE1VDd>; Tue, 28 May 2002 17:03:33 -0400
Received: from holomorphy.com ([66.224.33.161]:39310 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316951AbSE1VDd>;
	Tue, 28 May 2002 17:03:33 -0400
Date: Tue, 28 May 2002 14:03:14 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: cleanup -- use list_for_each in head_of_free_region
Message-ID: <20020528210314.GT14918@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Pavel Machek <pavel@ucw.cz>, torvalds@transmeta.com,
	kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020528193357.GA801@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2002 at 09:33:57PM +0200, Pavel Machek wrote:
> This cleans up is_head_of_free_region, thanks to William Lee Irwin III
> <wli@holomorphy.com>. Please apply,

Whoa! Mike Galbraith noticed a return without dropping the lock in there,
it's really easy to fix (of course), though.


Cheers,
Bill
