Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310190AbSE1WXf>; Tue, 28 May 2002 18:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312590AbSE1WXe>; Tue, 28 May 2002 18:23:34 -0400
Received: from ns.suse.de ([213.95.15.193]:1289 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S310190AbSE1WXd>;
	Tue, 28 May 2002 18:23:33 -0400
To: "Shipman, Jeffrey E" <jeshipm@sandia.gov>
Cc: linux-kernel@vger.kernel.org
Subject: Re: module question
In-Reply-To: <03781128C7B74B4DBC27C55859C9D7380984062E@es06snlnt.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 29 May 2002 00:23:33 +0200
Message-ID: <p73bsazewt6.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Shipman, Jeffrey E" <jeshipm@sandia.gov> writes:

> I have been assigned to a project where we are trying to fool
> OS footprinters into thinking the machine is running another
> OS. I was thinking I could write a module which registers
> a packet handler to modify the TCP/IP headers as necessary.
> I haven't really looked into this all much.

It's probably impossible to fool advanced tools like http://www.icir.org/tbit/
unless you change some fundamental algorithms in linux TCP  (like the 
retransmit state machine) or replace it with another TCP. 

-Andi
