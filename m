Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269226AbRHGUXj>; Tue, 7 Aug 2001 16:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269417AbRHGUX3>; Tue, 7 Aug 2001 16:23:29 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:19731 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S269226AbRHGUXU>;
	Tue, 7 Aug 2001 16:23:20 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Dave Jones <davej@suse.de>
Date: Tue, 7 Aug 2001 22:22:55 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: RE: cpu not detected(x86)
CC: Nico Schottelius <nicos@pcsystems.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        andrew.grover@intel.com
X-mailer: Pegasus Mail v3.40
Message-ID: <232AAD1EBC@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  7 Aug 01 at 22:09, Dave Jones wrote:
> 
> "The counter is incremented on every processor clock cycle,
>  even when the processor is halted by the HLT instruction or
>  the external STPCLK# pin"

But not if clocks are completely stopped, not through STPCLK, but
just stopped.
 
> "The RDTSC instruction reads the time-stamp counter and is
>   _guaranteed_ to return a monotonically increasing unique value
>  _whenever_ executed, except for 64-bit wraparound".

This only says that two consecutive RDTSC do not return same value.
                                            Best regards,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
