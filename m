Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277112AbRKMRPo>; Tue, 13 Nov 2001 12:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277165AbRKMRPe>; Tue, 13 Nov 2001 12:15:34 -0500
Received: from [216.151.155.121] ([216.151.155.121]:43793 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S277112AbRKMRPS>; Tue, 13 Nov 2001 12:15:18 -0500
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x has finally made it!
In-Reply-To: <Pine.GSO.4.33.0111131002200.14971-100000@gurney>
	<20011113171836.A14967@emma1.emma.line.org>
	<m34rnyk511.fsf@belphigor.mcnaught.org>
	<20011113174250.A15774@emma1.emma.line.org>
From: Doug McNaught <doug@wireboard.com>
Date: 13 Nov 2001 12:15:12 -0500
In-Reply-To: Matthias Andree's message of "Tue, 13 Nov 2001 17:42:50 +0100"
Message-ID: <m3vggeiodb.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@stud.uni-dortmund.de> writes:

> On Tue, 13 Nov 2001, Doug McNaught wrote:
> 
> > It's a benchmark, lighten up!  ;)
> 
> Well, he wanted to benchmark everyday use, and disk latency is also an
> issue for everyday use, of course;

But it's more a measure of your disk subsystem than your VM efficiency 
(unless something is badly wrong). 

>                                   so that's kind of pointless getting
> rid of I/O and benchmarking the cache. fsync() efficiency comes into
> play and wants to be benchmarked as well. How do you know if your
> fsync() syncs what's needed, the whole partition, the partition's meta
> data (softupdates!) or the world (all blocks)?

A very good point that I hadn't considered. 

-Doug
-- 
Let us cross over the river, and rest under the shade of the trees.
   --T. J. Jackson, 1863
