Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292972AbSCEMXH>; Tue, 5 Mar 2002 07:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293011AbSCEMW7>; Tue, 5 Mar 2002 07:22:59 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:20740 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S292972AbSCEMWr>; Tue, 5 Mar 2002 07:22:47 -0500
Date: Tue, 5 Mar 2002 09:22:25 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Andrea Arcangeli <andrea@suse.de>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Bill Davidsen <davidsen@tmr.com>, Mike Fedyk <mfedyk@matchmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19pre1aa1
In-Reply-To: <20020305024046.Y20606@dualathlon.random>
Message-ID: <Pine.LNX.4.44L.0203050921510.1413-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Mar 2002, Andrea Arcangeli wrote:
> On Mon, Mar 04, 2002 at 10:26:30PM -0300, Rik van Riel wrote:
> > On Tue, 5 Mar 2002, Andrea Arcangeli wrote:
> > > On Mon, Mar 04, 2002 at 09:01:31PM -0300, Rik van Riel wrote:
> > > > This could be expressed as:
> > > >
> > > > "node A"  HIGHMEM A -> HIGHMEM B -> NORMAL -> DMA
> > > > "node B"  HIGHMEM B -> HIGHMEM A -> NORMAL -> DMA

> the example you made doesn't have highmem at all.
>
> > has 1 ZONE_NORMAL and 1 ZONE_DMA while it has multiple
> > HIGHMEM zones...
>
> it has multiple zone normal and only one zone dma. I'm not forgetting
> that.

Your reality doesn't seem to correspond well with NUMA-Q
reality.

Rik
-- 
Will hack the VM for food.

http://www.surriel.com/		http://distro.conectiva.com/

