Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291477AbSCOMR1>; Fri, 15 Mar 2002 07:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291531AbSCOMRS>; Fri, 15 Mar 2002 07:17:18 -0500
Received: from tapu.f00f.org ([66.60.186.129]:1432 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S291477AbSCOMRG>;
	Fri, 15 Mar 2002 07:17:06 -0500
Date: Fri, 15 Mar 2002 04:16:56 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Momchil Velikov <velco@fadata.bg>, Anton Blanchard <anton@samba.org>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
Message-ID: <20020315121656.GA8030@tapu.f00f.org>
In-Reply-To: <20020313085217.GA11658@krispykreme> <20020314112725.GA2008@krispykreme> <87wuwfxp25.fsf@fadata.bg> <E16la2m-0000SX-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16la2m-0000SX-00@starship>
User-Agent: Mutt/1.3.27i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2002 at 07:33:40PM +0100, Daniel Phillips wrote:

    On March 14, 2002 02:21 pm, Momchil Velikov wrote:

    > Out of curiousity, why there's a need to update the linux page
    > tables ?  Doesn't pte/pmd/pgd family functions provide enough
    > abstraction in order to maintain _only_ the hashed page table ?

    No, it's hardwired to the x86 tree view of page translation.

What about doing soft TLB reloads then?


  --cw
