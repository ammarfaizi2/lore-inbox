Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130579AbRBJJLi>; Sat, 10 Feb 2001 04:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131230AbRBJJL2>; Sat, 10 Feb 2001 04:11:28 -0500
Received: from kerberos.suse.cz ([195.47.106.10]:53511 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S130579AbRBJJLM>;
	Sat, 10 Feb 2001 04:11:12 -0500
Date: Sat, 10 Feb 2001 10:11:08 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Philip Langdale <philipl@mail.utexas.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [preview] VIA IDE 4.0 and AMD IDE 2.0 with automatic PCI clock detection
Message-ID: <20010210101108.A665@suse.cz>
In-Reply-To: <3A84726C.4B07B601@mail.utexas.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A84726C.4B07B601@mail.utexas.edu>; from philipl@mail.utexas.edu on Fri, Feb 09, 2001 at 04:42:52PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2001 at 04:42:52PM -0600, Philip Langdale wrote:
>  	
> Content-Type: text/plain; charset=us-ascii
> Content-Transfer-Encoding: 7bit
> 
> Vojtech,
> 
> I've tried out your new via driver and it
> appears to have solved the problem with
> the mis-detected ls-120 drive, but the ata66
> drives are still being run at 33. 
> 
> More interestingly, the pci-clk calculations
> seem to be returning badly off values.
> 
> My motherboard is a kt133a+686b btk7a from abit.
> 
> When I set the FSB to 133 with PCI=133/4=33 the
> timing code returns 43mhz.
> 
> when I set the FSB to 100 with PCI=100/3=33 then
> it returns 42mhz.
> 
> These are scarely different from the nominal values.
> I didn't observe anything bad in the few minutes
> I was running like this, but right now I've hacked
> the driver back to a hardcoded 33.
> 
> What should I do next?

Are you willing to do some experiments? I suppose the 686b is somewhat
different than the other chips (I tested it on 686a and 586b).

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
