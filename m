Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129688AbRBVVm4>; Thu, 22 Feb 2001 16:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130910AbRBVVmh>; Thu, 22 Feb 2001 16:42:37 -0500
Received: from dfw7-1.relay.mail.uu.net ([199.171.54.106]:47860 "EHLO
	dfw7-1.relay.mail.uu.net") by vger.kernel.org with ESMTP
	id <S129688AbRBVVmb>; Thu, 22 Feb 2001 16:42:31 -0500
Date: Thu, 22 Feb 2001 16:41:11 -0600
From: Neal Nelson <neal@nna.com>
Message-Id: <200102222241.QAA22241@nna002.nna.com>
To: linux-kernel@vger.kernel.org
Subject: Shaper? CBQ?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to set up a Linux box as a bridge that will limit
throughput (and maybe even introduce delays in forwarding). I
am running 2.2.16-22 (RedHat 7.0). I have bridging working
between two lan cards.

I thought maybe I could limit transmit speed on one lan card
with shaper0 and limit the transmit speed of the other lan
card as shaper1.

When I try to configure shaper1 I get a "no such device"
message. The shaper.c source code shows shaper0-3. Should
there be a shaper1?

Can I shape two cards on the same machine? If so how?

If not, should I configure two machines as bridges and shape
one card in each machine?

Should the shaper code work with the bridging code?

Should I not use shaper at all? Maybe I should use CBQ?

Thanks in advance.

Neal Nelson
neal@nna.com

