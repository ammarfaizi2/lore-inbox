Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbWAQOww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWAQOww (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 09:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbWAQOwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 09:52:20 -0500
Received: from gold.veritas.com ([143.127.12.110]:46902 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1750736AbWAQOvR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 09:51:17 -0500
Date: Tue, 17 Jan 2006 14:51:44 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Ram Gupta <ram.gupta5@gmail.com>
cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>, Valdis.Kletnieks@vt.edu,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Shared memory usage
In-Reply-To: <728201270601161430y4a381bfcs3a470f09287769c@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0601171440350.6263@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0601160909590.22754@chaos.analogic.com> 
 <200601161848.k0GIm3xH016052@turing-police.cc.vt.edu> 
 <Pine.LNX.4.61.0601161510050.23899@chaos.analogic.com>
 <728201270601161430y4a381bfcs3a470f09287769c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 17 Jan 2006 14:51:12.0786 (UTC) FILETIME=[75C8DF20:01C61B75]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jan 2006, Ram Gupta wrote:
> Did you think about getting shared memory information using
> shmctl(IPC_STAT). It provides useful information but I am not sure if
> that will serve your purpose fully.

/proc/sysvipc/shm would be easier (showing for all the shmids).

But yes, these won't go very far towards "auditing all possible
communications channels".  Nor would a "MemShared" number, nor
a total of "pages shared", whatever they mean.

Hugh
