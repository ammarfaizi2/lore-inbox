Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129121AbQKOFCA>; Wed, 15 Nov 2000 00:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129170AbQKOFBu>; Wed, 15 Nov 2000 00:01:50 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:38928 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S129121AbQKOFBf>;
	Wed, 15 Nov 2000 00:01:35 -0500
To: Val Henson <vhenson@esscom.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] acenic driver update
In-Reply-To: <200011140031.TAA13437@plonk.linuxcare.com> <20001114184505.X18364@esscom.com>
From: Jes Sorensen <jes@linuxcare.com>
Date: 15 Nov 2000 05:31:27 +0100
In-Reply-To: Val Henson's message of "Tue, 14 Nov 2000 18:45:05 -0700"
Message-ID: <d3aeb1yhy8.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Val" == Val Henson <vhenson@esscom.com> writes:

Val> Jes, I just downloaded the 0.48 acenic driver and it still has a
Val> reproducible null dereference bug.  Anyone can oops their machine
Val> by doing:

Bugger I think I lost your patch in the noise. Sorry about that, it'll
be in the next version.

Val> ifconfig <gige> mtu 9000 ping -f -s 60000 <remote gige host>
Val> ifconfig <gige> mtu 1500 ping -f -s 60000 <remote gige host>

Val> I don't have a fix for this.

Hmmm could be a firmware issue, I'll need to look at it. It is however
a kind of bug that only root can cause deliberately. Doing ifconfig
mtu foo ; ifconfig mtu bar is a little far from normal operation ;-)

Thanks
Jes
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
