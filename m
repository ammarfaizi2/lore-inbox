Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285472AbRLSUtM>; Wed, 19 Dec 2001 15:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285469AbRLSUtD>; Wed, 19 Dec 2001 15:49:03 -0500
Received: from [207.148.204.33] ([207.148.204.33]:33035 "HELO
	erasure.jasnik.net") by vger.kernel.org with SMTP
	id <S285472AbRLSUsv>; Wed, 19 Dec 2001 15:48:51 -0500
Subject: Suggestions for linux security patches
From: Jason Czerak <Jason-Czerak@Jasnik.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 19 Dec 2001 15:48:46 -0500
Message-Id: <1008794926.842.6.camel@neworder>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running linux 2.4.16, and I"m looking to the best possibly kernel
patch to harden things up a bit. Primarly I wish to have what is in
openwall's and grsecurity's patches is the buffer oveflow protection,
but I'm unable to use the openwall patch because it only support 2.2.X
kernels ATM. I applied the grsecurity patch but for some reason when
running mozilla as non-root, the GUI for mozilla is all messed up (and I
enabled sysctl support so nothing was enabled by default except stuff
that isn't able to use sysctl).

So to advoid applying 20 or so differnet patches, and evaluate each of
them (taking up what little time I have in a day...), I wish to get the
lists opinions on the matter.

Local security/control isn't much of an issue and most likly won't be
for a while. Remote security and protection from server deamons that
have buffer problems are high priority to get the best protection for. 


--
Jason Czerak

