Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273815AbRIRDJx>; Mon, 17 Sep 2001 23:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273816AbRIRDJd>; Mon, 17 Sep 2001 23:09:33 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:48402 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273815AbRIRDJ3>; Mon, 17 Sep 2001 23:09:29 -0400
Subject: Re: Linux 2.4.10-pre11
To: torvalds@transmeta.com (Linus Torvalds)
Date: Tue, 18 Sep 2001 04:14:01 +0100 (BST)
Cc: bcrl@redhat.com (Benjamin LaHaise), andrea@suse.de (Andrea Arcangeli),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.33.0109171919330.1068-100000@penguin.transmeta.com> from "Linus Torvalds" at Sep 17, 2001 07:27:31 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15jBKj-0008Tu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The bug fixes in -ac that aren't merged into -linus are that way BECAUSE
> NOBODY HAS SENT ME MERGES.

Actually some of them I've sent you many times. The tlb fix I have on 
my list of "dont bother" for example - which means I got bored of sending
it.

> Alan works on it quite intensively, but the fact is, that for the -ac
> merge, Alan seems to be able to merge it slower than -ac grows. Which is
> why I actually started asking people to merge their parts from -ac into
> -linus to help Alan. That's how the other merge in -pre11 happened.

I've been trying to ensure I feed stuff in testable chunks. For example
I dont want vfs and scsi changes both in a Linus merge because someone is
bound to go "hey I got corruption" and then with both in one merge we
are screwed

Alan
