Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265691AbUFIIRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265691AbUFIIRL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 04:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265698AbUFIIRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 04:17:11 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:6029 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S265691AbUFIIRF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 04:17:05 -0400
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: keyboard problem with 2.6.6
References: <xb7oenxyqly.fsf@savona.informatik.uni-freiburg.de>
	<200406071551.i57Fpl89023562@turing-police.cc.vt.edu>
	<xb7zn7fwdia.fsf@savona.informatik.uni-freiburg.de>
	<200406071636.i57Gafh7024942@turing-police.cc.vt.edu>
	<xb7r7sqwncc.fsf@savona.informatik.uni-freiburg.de>
	<200406081502.i58F2gF3013622@turing-police.cc.vt.edu>
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 09 Jun 2004 10:17:04 +0200
In-Reply-To: <200406081502.i58F2gF3013622@turing-police.cc.vt.edu>
Message-ID: <xb765a1uovz.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Valdis" == Valdis Kletnieks <Valdis.Kletnieks@vt.edu> writes:

    Valdis> The whole 'init=/bin/bash' style of recovery has been
    Valdis> widely documented and often used (for instance, it's
    Valdis> covered in the RHCE class and used in one of the hands-on
    Valdis> labs to recover a non-booting system).  That's a lot of
    Valdis> people to retrain, and a lot of systems that need
    Valdis> changing...

    Valdis> (Trust me - if it's 3AM, and you type 'init=/bin/sh' and
    Valdis> it outputs the '#' but won't take input, you WONT think of
    Valdis> that kernel and initscripts change from 3 months ago...)

Explain to me how a kernel compiled with
        CONFIG_SERIO=m
        CONFIG_KEYBOARD_ATKBD=m
would be able to boot with "init=/bin/sh" and still have the keyboard
working.

I've just verified that "make allmodconfig", which is what many people
are tempted  to do once they've  learnt about it, will  produce such a
.config.




-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

