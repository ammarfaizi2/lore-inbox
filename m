Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290745AbSARQtV>; Fri, 18 Jan 2002 11:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290747AbSARQtL>; Fri, 18 Jan 2002 11:49:11 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:44811 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S290739AbSARQrr>;
	Fri, 18 Jan 2002 11:47:47 -0500
Date: Fri, 11 Jan 2002 23:21:10 +0000
From: Pavel Machek <pavel@suse.cz>
To: William Lee Irwin III <wli@holomorphy.com>,
        Peter W?chtler <pwaechtler@loewe-komp.de>,
        Christoph Hellwig <hch@caldera.de>, linux-mm@kvack.org,
        lkml <linux-kernel@vger.kernel.org>, velco@fadata.bg
Subject: Re: [PATCH] updated version of radix-tree pagecache
Message-ID: <20020111232110.A260@toy.ucw.cz>
In-Reply-To: <20020105171234.A25383@caldera.de> <3C3972D4.56F4A1E2@loewe-komp.de> <20020107030344.H10391@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020107030344.H10391@holomorphy.com>; from wli@holomorphy.com on Mon, Jan 07, 2002 at 03:03:44AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I speculate this would be good for small systems as well as it reduces
> the size of struct page by 2*sizeof(unsigned long) bytes, allowing more
> incremental allocation of pagecache metadata. I haven't tried it on my
> smaller systems yet (due to lack of disk space and needing to build the
> cross-toolchains), though I'm now curious as to its exact behavior there.

Why not mem=8M, nosmp on your "big" system?
								Pavel

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

