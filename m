Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131236AbRC3JW3>; Fri, 30 Mar 2001 04:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131248AbRC3JWK>; Fri, 30 Mar 2001 04:22:10 -0500
Received: from toxo.com.uvigo.es ([193.146.38.146]:55815 "EHLO
	lixo.com.uvigo.es") by vger.kernel.org with ESMTP
	id <S131236AbRC3JV6>; Fri, 30 Mar 2001 04:21:58 -0500
Message-ID: <3AC4508E.7C7E7E64@com.uvigo.es>
Date: Fri, 30 Mar 2001 11:23:26 +0200
From: Eduardo Diaz Comellas <ediaz@com.uvigo.es>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-ac2 i686)
X-Accept-Language: es, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problem with swap on 2.4.x
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I've got a linux 2.4 machine acting as a router, with an ATM
(Fore PCA-200E) and two 3c905C nics. This system has been
experiencing kernel panics since it was put in production state.

I've tried several kernels (from 2.4.0-test to 2.4.2-ac21)
with no luck. It always gives the same message (Unable to
dereference null pointer, killing interrupt handler).

The process shown in the crash message changed from time
to time, sometimes it was the atm signaling daemon (atmsigd)
and others the swapper.

Reading the mailing list, I found some reference to the
amount of swap needed with the 2.4 kernel series (2*RAM),
but after increasing the swap area the problem persisted.
At last, I tried increasing the RAM and deactivating the swap,
and it seems that this was the rigth move, as the system has
been working flawlessly afterwards.

I am sorry I dont have the exact kernel panic's messages. I'm
just
telling this here in case it is of any help.

Regards.


