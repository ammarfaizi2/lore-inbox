Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317882AbSFNER0>; Fri, 14 Jun 2002 00:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317883AbSFNERZ>; Fri, 14 Jun 2002 00:17:25 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:45821 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S317882AbSFNERZ>; Fri, 14 Jun 2002 00:17:25 -0400
Date: Fri, 14 Jun 2002 00:17:26 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
        Richard Brunner <richard.brunner@amd.com>, mark.langsdorf@amd.com
Subject: Re: New version of pageattr caching conflict fix for 2.4
Message-ID: <20020614001726.D21542@redhat.com>
In-Reply-To: <20020613221533.A2544@wotan.suse.de> <20020613210339.B21542@redhat.com> <20020614032429.A19018@wotan.suse.de> <20020613213724.C21542@redhat.com> <20020614040025.GA2093@inspiron.birch.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2002 at 06:00:25AM +0200, Andrea Arcangeli wrote:
> just a fast comment on this bit: x86 specs state invlpg must flush
> global entries from the tlb too, see also the kmap_prot as pratical
> reference.

It's not the 4KB pages that I'm worried about so much as the 4MB pages.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
