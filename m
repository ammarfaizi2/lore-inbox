Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274096AbRIXRw0>; Mon, 24 Sep 2001 13:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274097AbRIXRwS>; Mon, 24 Sep 2001 13:52:18 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:4365 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S274096AbRIXRwM>;
	Mon, 24 Sep 2001 13:52:12 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Dave McCracken <dmc@austin.ibm.com>
Date: Mon, 24 Sep 2001 19:52:13 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Binary only module overview
CC: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <46458FB0D75@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Sep 01 at 12:24, Dave McCracken wrote:
> >> IIRC, vmware includes one or more kernel modules.
> >>
> >> Rasmus
> >>
> > Yes, but the modules are not binary-only.
> > The sourcecode is in the package, although it is not GPL.
> 
> I believe they only provide source for an interface layer that can be 
> compiled against a specific version of the kernel.  I think the core 
> drivers are binary only.

VMnet and VMppuser drivers are completely standalone and can work
without VMware. You can persuade VMmon module to load and execute
arbitrary code on kernel level - it just provides virtual machine
environment (switches CPU context), but as it even does not link to
anything else, I do not see any problem here. DRI drivers also allows
you to smash arbitrary piece of memory...

As for license on these modules - I was under impression that they are
under GPL, but I'll ask VMware for clarification.
                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz

