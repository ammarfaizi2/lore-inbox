Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271856AbRH1RTH>; Tue, 28 Aug 2001 13:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271851AbRH1RSs>; Tue, 28 Aug 2001 13:18:48 -0400
Received: from mx6.port.ru ([194.67.57.16]:8457 "EHLO smtp6.port.ru")
	by vger.kernel.org with ESMTP id <S271856AbRH1RSf>;
	Tue, 28 Aug 2001 13:18:35 -0400
From: Samium Gromoff <_deepfire@mail.ru>
Message-Id: <200109272141.f8RLfKI03553@vegae.deep.net>
Subject: 2.4.9-ac1 slight RT sluggishness
To: lkml@vegae.deep.net
Date: Thu, 27 Sep 2001 21:41:19 +0000 (UTC)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

                Just collected all the facts in a bunch:
      1. There is a svgalib fast-action game called koules.
   Koules intro eventually delays by about 1/10 sec, and it is _visible_.
      2. Again these delays while playing music: mpg123+esd.
      3. Again these delays are in sync with gpm mouse stalls.
  I.e when sound stops for its 1/10 sec, mouse stops to respond too.

a) mpg123 is reniced at -20.
b) "find /" doesnt seem to affect this behaviour.
c) it is a somewhat flashing effect: one minute it triggers
  each 5 secs or so, next 10 minutes i do not see it.
d) CPU load is in its right limits.

p166/24M/2.4.9-ac1/2.95.3

cheers,
 Sam 

