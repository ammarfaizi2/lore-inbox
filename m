Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281806AbRLLTO4>; Wed, 12 Dec 2001 14:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281808AbRLLTOq>; Wed, 12 Dec 2001 14:14:46 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:8198 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S281806AbRLLTOe>;
	Wed, 12 Dec 2001 14:14:34 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Pozsar Balazs <pozsy@sch.bme.hu>
Date: Wed, 12 Dec 2001 20:13:59 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: FBdev remains in unusable state
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <BCDCADB4194@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Dec 01 at 19:49, Pozsar Balazs wrote:
> 
> The video card is a matrox G450, and I am using the vesa framebuffer.
> (I know there's a seperate mga fb driver, but this should work for this
> combination)

No. vesafb does not work together with mga driver in X (although
I believe that vesafb works with XFree mga driver, only Matrox driver
is binary bad citizen).
 
> Is this a bug in the kernel fb code, or in X? Are there any workarounds?
> How could I restore textmode?

Neither. X restore R/W registers to their previous values, while write-only
registers to their values for normal text mode. Yes, there is a 
'workaround'. Use (much faster) matroxfb.
                                                    Best regards,
                                                        Petr Vandrovec
                                                        vandrove@vc.cvut.cz
                                                        
                                                        
