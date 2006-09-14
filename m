Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750696AbWINRDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750696AbWINRDg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 13:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbWINRDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 13:03:35 -0400
Received: from max.feld.cvut.cz ([147.32.192.36]:27555 "EHLO max.feld.cvut.cz")
	by vger.kernel.org with ESMTP id S1750758AbWINRDe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 13:03:34 -0400
From: CIJOML <cijoml@volny.cz>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Microsoft BT mouse's optical sensor switches off???
Date: Thu, 14 Sep 2006 19:03:31 +0200
User-Agent: KMail/1.9.3
Cc: Pavel Machek <pavel@suse.cz>, bluez-users@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <200608240859.11195.cijoml@volny.cz> <20060824130946.GB7055@elf.ucw.cz>
In-Reply-To: <20060824130946.GB7055@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200609141903.32000.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi I fixed this issue - Sensor switches off if hcid daemon doesn't run. If 
does, everythink works fine!

I find out that hcid not running, because I was missing DBUS.

Hope this will help others having this issue.

Michal

Dne ètvrtek 24 srpen 2006 15:09 Pavel Machek napsal(a):
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
