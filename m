Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314380AbSEXNRw>; Fri, 24 May 2002 09:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314394AbSEXNRv>; Fri, 24 May 2002 09:17:51 -0400
Received: from cmailg7.svr.pol.co.uk ([195.92.195.177]:19784 "EHLO
	cmailg7.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S314380AbSEXNRv>; Fri, 24 May 2002 09:17:51 -0400
Posted-Date: Fri, 24 May 2002 08:06:11 GMT
Date: Fri, 24 May 2002 09:06:10 +0100 (BST)
From: Riley Williams <rhw@InfraDead.Org>
Reply-To: Riley Williams <rhw@InfraDead.Org>
To: Ron Gage <ron@rongage.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFQ] - Kernel Janitor Project - Compiler Cleanups
In-Reply-To: <1021826787.7867.32.camel@portable>
Message-ID: <Pine.LNX.4.21.0205240903420.1541-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ron.

> To expose the warnings, all one needs to do is change the CC
> defination from "gcc" to "gcc -w" in the toplevel Makefile.

I seem to remember somewhere that CC should always be defined to be just
the name of the executable, and any flags should be defined in CFLAGS
rather than in CC itself. Memory says that in some circumstances, make
can do the wrong thing if this rule isn't followed.

Perhaps somebody can confirm this?

Best wishes from Riley.

