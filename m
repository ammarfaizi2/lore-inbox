Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137108AbREKLPD>; Fri, 11 May 2001 07:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137109AbREKLOy>; Fri, 11 May 2001 07:14:54 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:40207 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S137107AbREKLOe>;
	Fri, 11 May 2001 07:14:34 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Fri, 11 May 2001 13:12:53 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.4.2 - Locked keyboard
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <2991890558C@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 May 01 at 18:59, Alan Cox wrote:
> >     I changed the keyboard and looked at the keyboard plugs unsucessful=
> > ly.
> > 
> >     Could this be related to a kernel bug or an userspace issue??? How =
> > can I
> > debug it?
> 
> I think its kernel related. There are a few other reports of 'my computer
> is fine but they keyboard stopped working' with 2.4.x. Does the box have
> a ps/2 mouse ?

Just FYI - all my boxes with PS/2 connector without connected mouse (and 
psaux compiled into kernel) stop responding to keyboard as soon as gpm 
starts. If I kill gpm, keyboard starts working again. I never investigated 
it, as I assumed that it is just admin mistake to run gpm without mouse. 
It should not behave this way?

                                        Best regards,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
