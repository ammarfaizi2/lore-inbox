Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268432AbRHYSKg>; Sat, 25 Aug 2001 14:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268217AbRHYSK1>; Sat, 25 Aug 2001 14:10:27 -0400
Received: from h226-58.adirondack.albany.edu ([169.226.226.58]:9094 "EHLO
	bouncybouncy") by vger.kernel.org with ESMTP id <S269002AbRHYSKT>;
	Sat, 25 Aug 2001 14:10:19 -0400
Date: Sat, 25 Aug 2001 14:09:29 -0400
From: Justin A <justin@bouncybouncy.net>
To: linux-kernel@vger.kernel.org
Subject: recent changes in emu10k1
Message-ID: <20010825140929.A25734@bouncybouncy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This probably belongs on the emu10k1 list but that was down last I tried...

One of the recent changes in the emu10k1 module causes my card to go mute.  I
can plug the speakers into the rear port(black right?) and sound will work...If
I play a dvd with xine I need to switch it to the front port(green?)...Running
emu-script mutes both ports even though in aumix everything is 75%.

The card used to work fine before the merge, but had the same problem when
using the creative cvs drivers...

The card I have is the 'value' I think so I have emu-script as so:
CARD_IS_5_1=no
USE_DIGITAL_OUTPUT=no
ENABLE_TONE_CONTROL=yes
...
MULTICHANNEL=no

Changing those settings doesn't make a difference.

-Justin
