Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129415AbQLLWkT>; Tue, 12 Dec 2000 17:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129969AbQLLWkJ>; Tue, 12 Dec 2000 17:40:09 -0500
Received: from mandy.eunet.fi ([193.66.1.129]:3303 "EHLO mandy.eunet.fi")
	by vger.kernel.org with ESMTP id <S129543AbQLLWjw>;
	Tue, 12 Dec 2000 17:39:52 -0500
Message-ID: <3A36A163.3F01277D@jlaako.pp.fi>
Date: Wed, 13 Dec 2000 00:06:27 +0200
From: Jussi Laako <jussi@jlaako.pp.fi>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: VM problem (2.4.0-test11)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Would it be possible to implement some VM CPUtime/bandwidth limitation?

We have server used by multiple developers. Problem is when someone happens
to implement memory hole to application the system goes wild swapping and
ALL other activity stops. No response to keyboard/mouse events nor any
network traffic. Only disk system running wildly. No way to stop the
memoryhog application, only way out of this situation is to hit reset-button
and hope that no important data is lost. Same thing happens when I forget to
end some large matrix operation with semicolon in Octave... (and 2.2.x
kernels at least with Octave) I'm still considering this as local DOS attack
because normal user is able to overload the system.

Rebooting system all the time is annoying.

It would be nice to be able to tell system that "this process may use max
256 MB of memory and 10% of disk IO bandwidth and 25% of network bandwidth
and network IO latency is critical and disk io is not".

Kernel is stock except Andrew Morton's lowlatency patch.

Regards,

 - Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at: ldap://certserver.pgp.com, http://keys.pgp.com:11371

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
