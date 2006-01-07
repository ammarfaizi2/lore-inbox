Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030515AbWAGRnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030515AbWAGRnW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 12:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030517AbWAGRnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 12:43:21 -0500
Received: from wasp.net.au ([203.190.192.17]:42371 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S1030515AbWAGRnV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 12:43:21 -0500
Message-ID: <43BFFE08.70808@wasp.net.au>
Date: Sat, 07 Jan 2006 21:44:40 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Sebastian <sebastian_ml@gmx.net>
CC: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Digital Audio Extraction with ATAPI drives far from perfect
References: <20060106232522.GA31621@section_eight.mops.rwth-aachen.de> <5bdc1c8b0601061530l3a8f4378o3b9cb96c187a6049@mail.gmail.com> <20060107103901.GA17833@section_eight.mops.rwth-aachen.de> <20060107105649.GT3389@suse.de> <20060107112443.GA18749@section_eight.mops.rwth-aachen.de> <20060107115340.GW3389@suse.de> <20060107115449.GB20748@section_eight.mops.rwth-aachen.de> <20060107115947.GY3389@suse.de> <20060107140843.GA23699@section_eight.mops.rwth-aachen.de> <20060107142201.GC3389@suse.de> <20060107160622.GA25918@section_eight.mops.rwth-aachen.de>
In-Reply-To: <20060107160622.GA25918@section_eight.mops.rwth-aachen.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian wrote:
> 
> Yay, problem solved!
> 


> 
> P.S.: I already reripped the test disc using ide-cd and the
> SG_IO-patched cdparanoia and the results are perfect. OMG, I bought Win
> XP Home 2 months ago because of this (so I can use Exact Audio Copy). I
> guess I can remove XP from my drive now and sell it to some wretched guy :)
> Harhar.
> 
> S.

Yes, but now we need to find out why one interface fails while another works.. I have the same 
problem here using cdrdao when ripping entire disk images. I'd love to fix the real issue rather 
than work around it by having userspace use another interface.
I would have thought that both interfaces should return the same data..

Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
