Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261402AbREQLtU>; Thu, 17 May 2001 07:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261403AbREQLtJ>; Thu, 17 May 2001 07:49:09 -0400
Received: from zeus.kernel.org ([209.10.41.242]:55258 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261402AbREQLtD>;
	Thu, 17 May 2001 07:49:03 -0400
Subject: Re: Bug in unlink error return
To: Andries.Brouwer@cwi.nl
Date: Thu, 17 May 2001 12:45:07 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, viro@math.psu.edu
In-Reply-To: <UTC200105171126.NAA37619.aeb@vlet.cwi.nl> from "Andries.Brouwer@cwi.nl" at May 17, 2001 01:26:44 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E150MDL-0005F6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>        EISDIR pathname refers to a directory.  (This is the  non-
>               POSIX value returned by Linux since 2.1.132.)

it isnnt that simple -ac does the right thing now I believe

> Probably this should be fixed again, both in 2.2 and 2.4.
> 2.0 is still correct (I checked only ext2).

I'll check 2.2.20pre and fix it if so.

Alan

