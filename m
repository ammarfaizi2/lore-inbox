Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314323AbSDRLrB>; Thu, 18 Apr 2002 07:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314324AbSDRLrA>; Thu, 18 Apr 2002 07:47:00 -0400
Received: from ns.suse.de ([213.95.15.193]:41228 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S314323AbSDRLrA>;
	Thu, 18 Apr 2002 07:47:00 -0400
Date: Thu, 18 Apr 2002 13:46:57 +0200
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>, Andrea Arcangeli <andrea@suse.de>,
        Doug Ledford <dledford@redhat.com>, jh@suse.cz,
        linux-kernel@vger.kernel.org, jakub@redhat.com, aj@suse.de,
        pavel@atrey.karlin.mff.cuni.cz
Subject: Re: SSE related security hole
Message-ID: <20020418134657.B26709@wotan.suse.de>
In-Reply-To: <20020418131431.B22558@wotan.suse.de> <E16yATQ-0004V1-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2002 at 12:53:12PM +0100, Alan Cox wrote:
> > > Intel folks are actually saying even back in Pentium MMX days that it isnt
> > > guaranteed that the FP/MMX state are not seperate registers
> > 
> > In this case it would be possible to only do the explicit clear
> > when the CPU does support sse1. For mmx only it shouldn't be needed.
> > For sse2 also not.
> 
> Do you have a documentation cite for that claim ?

Never mind. It was a bogus suggestion and fninit indeed also doesn't clear
XMM on P4 and other SSE2 implementation.

-Andi

