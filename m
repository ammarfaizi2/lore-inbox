Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263100AbUGNU13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263100AbUGNU13 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 16:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263574AbUGNU12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 16:27:28 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:18332 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S263100AbUGNU1E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 16:27:04 -0400
Date: Wed, 14 Jul 2004 22:27:00 +0200
From: David Weinehall <tao@debian.org>
To: John Goerzen <jgoerzen@complete.org>
Cc: linux-kernel@vger.kernel.org, linux-thinkpad@linux-thinkpad.org
Subject: Re: ACPI Hibernate and Suspend Strange behavior 2.6.7/-mm1
Message-ID: <20040714202700.GF22472@khan.acc.umu.se>
Mail-Followup-To: John Goerzen <jgoerzen@complete.org>,
	linux-kernel@vger.kernel.org, linux-thinkpad@linux-thinkpad.org
References: <A6974D8E5F98D511BB910002A50A6647615FEF48@hdsmsx403.hd.intel.com> <1089054013.15671.48.camel@dhcppc4> <pan.2004.07.06.14.14.47.995955@physik.hu-berlin.de> <slrncfb55n.dkv.jgoerzen@christoph.complete.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <slrncfb55n.dkv.jgoerzen@christoph.complete.org>
User-Agent: Mutt/1.4.1i
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 08:16:55PM +0000, John Goerzen wrote:
> On 2004-07-06, Volker Braun <volker.braun@physik.hu-berlin.de> wrote:
> > ACPI S3 draws too much power on the T40/T41, this has been confirmed by
> > various people (so its not just mine). Suspended it lasts about 10h,
> > about twice as long as powered up. Supposed to be 1-2 weeks. 
> 
> I'm glad I'm not the only one that is suspecting that.  I just tried
> switching my T40p from APM to ACPI.  I got suspending to RAM working in
> ACPI, but noticed that when I got it back out of my laptop bag later, it
> was physically warm to the touch.  It also had consumed more battery
> power than it would have when suspended with APM.  And, if I would shine
> a bright light on the screen, I could make out text on it.  In other
> words, the backlight was off but it was still displaying stuff.

Does poweroff work for you?  At least my T40 has problems shutting off
properly when using 2.6 + ACPI.  A bit annoying; I have to keep the
powerkey pressed for a few seconds for it to turn off.


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
