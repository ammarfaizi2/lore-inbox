Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133056AbRECBn5>; Wed, 2 May 2001 21:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133070AbRECBnq>; Wed, 2 May 2001 21:43:46 -0400
Received: from mail2.bonn-fries.net ([62.140.6.78]:10760 "HELO
	mail2.bonn-fries.net") by vger.kernel.org with SMTP
	id <S133056AbRECBnd>; Wed, 2 May 2001 21:43:33 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][CFT] (updated) ext2 directories in pagecache
Date: Thu, 3 May 2001 03:43:59 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <01050303150500.00633@starship>
In-Reply-To: <01050303150500.00633@starship>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <01050303440002.00633@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 May 2001 03:15, you wrote:
> Hello Daniel,
> This combination against 2.4.4 won't allow directories to be moved.
> Ex: mv a b #fails with I/O error.  See attached strace.
> But with ext2-dir-patch-S4 by itself, mv works as it should.
> Later,
> Albert

Thanks Albert, this was easily reproduceable here but did not show
up with 2.4.2 (uml), which I'd used to develop the patch.  Analyzing
now...

--
Daniel
