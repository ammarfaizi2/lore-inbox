Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266219AbUFUNVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266219AbUFUNVH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 09:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266221AbUFUNVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 09:21:07 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:55539 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S266219AbUFUNVC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 09:21:02 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-bk way too fast
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 21 Jun 2004 15:20:59 +0200
Message-ID: <xb7r7s9nj2c.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Vojtech" == Vojtech Pavlik <vojtech@suse.cz> writes:

    Vojtech> It's possible that X does it's own autorepeat, though
    Vojtech> that'd rather surprise me.

Why?  XFree86 has been doing its own autorepeat, I think.

        $ xset q
        Keyboard Control:
          auto repeat:  on    key click percent:  0    LED mask:  00000000
          auto repeat delay:  660    repeat rate:  25
          auto repeating keys:  00ffffffdffffbbf
                                fa9fffffffdfe5ff
                                ffffffffffffffff
                                ffffffffffffffff
          bell percent:  50    bell pitch:  400    bell duration:  100

And I  can change it via "xset  r rate [delay [rate  ]]", according to
"xset help".  Indeed,  you can use 'xset' to  change the rate/delay to
very  extreme values,  which  exceed the  hardware  allowed on  AT/PS2
keyboards (e.g. rates > 30  cps), adjusted with the 'kbdrate' command.
So, the only  possibility for these hardware limits  to be transcended
is s/w based autorepeat.



-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

