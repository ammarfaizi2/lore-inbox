Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932579AbVJEIwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932579AbVJEIwP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 04:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932581AbVJEIwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 04:52:15 -0400
Received: from imag.imag.fr ([129.88.30.1]:2539 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S932579AbVJEIwP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 04:52:15 -0400
Date: Wed, 5 Oct 2005 10:47:38 +0200
From: Pierre Michon <pierre@no-spam.org>
To: linux-kernel@vger.kernel.org
Cc: legal@lists.gpl-violations.org
Subject: freebox possible GPL violation
Message-ID: <20051005084738.GA29944@linux.ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6+20040722i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (imag.imag.fr [129.88.30.1]); Wed, 05 Oct 2005 10:47:45 +0200 (CEST)
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I will try to present the facts and free claims about the freebox that run 
Linux GPL source code.

Please note that I am not a Laywer.

Also due to the obscurity of the freebox, some informations could be out of 
date or incorrect.

Finaly as free is a french provider, most of the link are in french.


==FACT==

1) The freebox is an adsl gateway with VoIP, TV over ADSL and a optional 
wifi bridge. The box is built and lended by an ADSL provider 'free'[0].

2) The freebox runs Linux 2.4. You could find some BitKeeper logs on 
internet [1], [2]. You could also find some interesting (but sometimes 
suspicious) informations on [3]. For example you could see the files that 
are in the firmware (and find other GPL softwares).

3) The boot sequence is described on [4]. Note that in case of firmware 
upgrade, the box should first synchronize with the dslam and do dhcp 
requests, then download the new firmware and finaly reboot.

4) The optional wifi support is provided by a pcmcia card (prism2/3 for 
802.11b, broadcom for 802.11g). You can buy it on 'free' portal or on 
your own [5]. Note that in both case the card is yours and it is not 
lended by 'free'.


==FREE and PRO-FREE CLAIMS (some claims could be find on [6])==

A) The freebox is only lended, so the user can't ask for GPL source code.

-> They forgot that for wifi feature, you have buy a pcmcia card and 
that is card works wifi Linux driver. So according to GPL you could ask 
for wifi driver source code and all the Linux source code ???
Also some people that don't return the freebox in time had to 
paid 400 Euros and they became the owner of the freebox. Free send to a 
client a letter [7] saying that if the user don't return the freebox, 
free could bill it and then it becomes propriety of the user : 
'Nous vous rappelons que conformément aux Conditions Générales de Vente , 
en cas de non-restitution du modem, Free se réserve le droit de procéder 
à la facturation de l'équipement terminal, au prix mentionné dans les CGV, 
qui deviendra alors la *propriété* de l'Usager.'


B) The freebox don't keep the Linux kernel in memory, it is downloaded 
at each boot.

-> If you remember 3), you could find strange that the box need to reboot 
if a new firmware is available. Also the boot sequence is quite complex to 
be made by an external (non-GPL) firmware : it need to control the led 
display, need to control the ADSL chips in order to synchronize, need 
to manage PPP in case of 'no-degroupe' users and finaly donwload in memory 
the fimware. So we could assume that at least a mininal system (Linux
kernel + some utils) is keep in rom).


C) 'Free' is a network operator and needs to keep secret some informations 
in order to preserve security on its networks.

-> Everybody know how security obscurity via is safe. Also I agree they
don't want to give their script or their configuration, but I fail to
see what could be a threat in the Linux kernel.


PS : sorry for my bad english.

[0] http://free.fr
[1] http://openlogging.org:8080/sakura.(none)/max-20040524220224-60268-baea416b9b2da5c2/src?nav=index.html
[2] http://openlogging.org:8080/chewbacca.proxad.net/rani-20040112173203-20972-c609c93690b2941a/src?nav=index.html
[3] http://www.f-b-x.net/
[4] http://forums.grenouille.com/index.php?showtopic=14659
[5] http://faq.free.fr/?q=797
[6] http://djeyl.net/free/nntp/index.php?group=all&author=Alexandre&headers=gpl
[7] http://linuxfr.org/comments/626391.html#626391
