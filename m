Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbUJXPHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbUJXPHN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 11:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbUJXPHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 11:07:09 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:11143 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261511AbUJXPHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 11:07:03 -0400
Subject: Re: How is user space notified of CPU speed changes?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: jonathan@jonmasters.org
Cc: Lee Revell <rlrevell@joe-job.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>
In-Reply-To: <35fb2e590410231635616f10c9@mail.gmail.com>
References: <1098399709.4131.23.camel@krustophenia.net>
	 <1098444170.19459.7.camel@localhost.localdomain>
	 <1098508238.13176.17.camel@krustophenia.net>
	 <1098566366.24804.8.camel@localhost.localdomain>
	 <35fb2e590410231635616f10c9@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098626656.24108.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 24 Oct 2004 15:04:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-10-24 at 00:35, Jon Masters wrote:
> Out of sheer interest, you said you had an example box which did this.
> I've never actually seen a modern SMP setup with different cock
> frequencies (even accepting it's possible) - can you give me a more
> modern example? I'm sure they're out there, I've just missed it, and I
> have to confess to not being aware that Linux supported this kind of
> setup.

The classic setups were dual PIII type systems - common FSB clock but
different multipliers for the processors. A lot of dual slot 1 boards
ended up with weird processor combinations.

Modern systems that don't tie the tsc include the big IBM 440 series
systems.

Alan

