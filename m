Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751553AbWHXN4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751553AbWHXN4W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 09:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751552AbWHXN4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 09:56:22 -0400
Received: from max.feld.cvut.cz ([147.32.192.36]:10899 "EHLO max.feld.cvut.cz")
	by vger.kernel.org with ESMTP id S1751551AbWHXN4V convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 09:56:21 -0400
From: CIJOML <cijoml@volny.cz>
To: Pavel Machek <pavel@suse.cz>, bluez-users@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Microsoft BT mouse's optical sensor switches off???
Date: Thu, 24 Aug 2006 15:56:09 +0200
User-Agent: KMail/1.9.3
References: <200608240859.11195.cijoml@volny.cz> <20060824130946.GB7055@elf.ucw.cz>
In-Reply-To: <20060824130946.GB7055@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200608241556.09836.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ahoj Pavle,

zkousel jsem vsechny predchozi jadra co tu mam 2.6.16.16,2.6.17.3 a delaj to 
taky. To vypada spis jako chybu v nejakem upgradovanem programu. Napadaj me 
Xka nebo BlueZ stack.

Co je zajimavy, ta prodleva je presne 60 sekund a moje druha BT mys Logitech 
V270 ani moje USB mys to nedelaji.

Michal

Hi Pavel,

I was testing all previous kernel versions I have (2.6.16.16, 2.6.17.3) which 
worked before and it is also happening in them now. So it looks like error in 
some external out-of-kernel stuff. Maybe X.org or BlueZ utils???

Is interresting, that delay when sensor switch off is 60 seconds (like some 
timer) and my second BT mouse Logitech V270 and also my USB mouse don't do 
that and sensor is always on. When I connect Microsoft mouse to W2000 or my 
old linux installation, sensor also don't switch off.

Any clue whom to ask now?

Thanks
Michal

Dne ètvrtek 24 srpen 2006 15:09 jste napsal(a):
> On Thu 2006-08-24 08:59:11, CIJOML wrote:
> > Hi,
> >
> > I upgraded my debian linux to newest testing version:
> >
> > notas:/usr/src/linux-2.6.18-rc4# dpkg -l|grep -i bluez
> > ii  bluez-hcidump                    1.31-1                      Analyses
> > Bluetooth HCI packets
> > ii  bluez-utils                      3.1-3.1                    
> > Bluetooth tools and daemons
> > ii  libbluetooth1                    2.25-2                      Library
> > to use the BlueZ Linux Bluetooth stack
> > ii  libbluetooth2                    3.1-1                       Library
> > to use the BlueZ Linux Bluetooth stack
> >
> > and linux kernel to 2.6.18-rc4 to have also latest BlueZ kernel.
> >
> > Everything works fine, except mouse?!
> >
> > Mouse works, but it sensor getts off in a very short time. I have to
> > click 2times any button on it to start it again to move cursor?!
> >
> > This really p*ss me off.
> >
> > Where can I switch off this "feature"??
>
> Find where it started happening with git bisect, then file proper
> bugzilla report, I'd say...
> 							Pavel
