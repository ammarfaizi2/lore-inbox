Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315481AbSFTTkl>; Thu, 20 Jun 2002 15:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315483AbSFTTkk>; Thu, 20 Jun 2002 15:40:40 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:45319 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S315481AbSFTTkj>;
	Thu, 20 Jun 2002 15:40:39 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Andries.Brouwer@cwi.nl
Date: Thu, 20 Jun 2002 21:40:27 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [linux-usb-devel] [PATCHlet] 2.5.23 usb, ide
CC: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       david-b@pacbell.net
X-mailer: Pegasus Mail v3.50
Message-ID: <8A6B34966F9@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Jun 02 at 20:49, Andries.Brouwer@cwi.nl wrote:
> 
> Now that you tell me that these things are set at initialization
> and never changed, the initialization must be wrong. And indeed,
> it says "__devexit_p(uhci_stop)" and this yields NULL.

Now when kernel tries to shutdown devices on poweroff, should
not we change __devexit_p() meaning? Like always build kernel with
hotplug enabled?
                                        Thanks,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
