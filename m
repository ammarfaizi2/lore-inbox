Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129102AbQJ0DQx>; Thu, 26 Oct 2000 23:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129289AbQJ0DQn>; Thu, 26 Oct 2000 23:16:43 -0400
Received: from kanga.kvack.org ([209.82.47.3]:24073 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id <S129102AbQJ0DQk>;
	Thu, 26 Oct 2000 23:16:40 -0400
Date: Thu, 26 Oct 2000 23:15:13 -0400 (EDT)
From: <kernel@kvack.org>
To: Wakko Warner <wakko@animx.eu.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test9 + LFS
In-Reply-To: <20001026215606.A19958@animx.eu.org>
Message-ID: <Pine.LNX.3.96.1001026231315.22907A-100000@kanga.kvack.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2000, Wakko Warner wrote:

> I attempted to create a 4gb sparce file with dd.  It failed.
> I created one that was 2.1gb in size which worked.  Then I appeneded more
> junk to the end of the file making it over 2.2gb.
> 
> doing an ls -l shows:
> ls: x: Value too large for defined data type
> 
> NOTE: this worked in 2.4.0-test6 and I believe it stopped working around
> test8, but I'm not sure.  May have been around test7.

Previous kernels allowed up to 4gb to be returned by the old stat.
Upgrade your glibc and fileutils -- most recent distributions (Red Hat,
SuSE, ...) are LFS ready, and the only reports I've seen about this
concerned Slackware.

		-ben

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
