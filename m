Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316906AbSE1VNj>; Tue, 28 May 2002 17:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316940AbSE1VNi>; Tue, 28 May 2002 17:13:38 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:60168 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S316906AbSE1VNg>; Tue, 28 May 2002 17:13:36 -0400
Date: Tue, 28 May 2002 23:13:39 +0200
From: Pavel Machek <pavel@ucw.cz>
To: William Lee Irwin III <wli@holomorphy.com>, torvalds@transmeta.com,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: cleanup -- use list_for_each in head_of_free_region
Message-ID: <20020528211338.GB28189@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020528193357.GA801@elf.ucw.cz> <20020528210314.GT14918@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This cleans up is_head_of_free_region, thanks to William Lee Irwin III
> > <wli@holomorphy.com>. Please apply,
> 
> Whoa! Mike Galbraith noticed a return without dropping the lock in there,
> it's really easy to fix (of course), though.

How is that possible? I actually tested that code! Fixed now...
									Pavel

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.









