Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271646AbRH0EDZ>; Mon, 27 Aug 2001 00:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271648AbRH0EDQ>; Mon, 27 Aug 2001 00:03:16 -0400
Received: from mx10.port.ru ([194.67.57.20]:32736 "EHLO mx10.port.ru")
	by vger.kernel.org with ESMTP id <S271646AbRH0EC7>;
	Mon, 27 Aug 2001 00:02:59 -0400
From: Samium Gromoff <_deepfire@mail.ru>
Message-Id: <200109260825.f8Q8PgM02002@vegae.deep.net>
Subject: 2.4.x & PPP-or-IP-or-TCP
To: lkml@vegae.deep.net
Date: Wed, 26 Sep 2001 08:25:42 +0000 (UTC)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

            hello again,
     cant tolerate more this feature: just cant get
  this brand new preemption patch, just because ppp_interface_error_count
  absolutely_selectively_data_dependant increases!

     for interested and wanting to help:
 http://tech9.net/rml/linux/patch-rml-2.4.8-ac12-preempt-kernel-1
    just cant get. no way. period.

     not closely related details:
  on my old 5x86 that was quite a curse: 2.2 - ok, 2.4 - silent death,
  85% of packets died on this ppp interface (that was another issue,
  and mostly wasnt data dependant(i.e. data dependant was 3% of all errors)),
  and also packets which had an unfortunateness to be received at one time
  with disk access also were 99% dead.

     here and now:
  doesnt depend on packet compression: deflate/bsd/vj - etc
  doesnt depend on v42 modem compression.
  tried 2 differrent modems(sportster 14400 voice/ Zyxel omni 56k).
  ppp 2.4.0.

  sounds for me like a ppp crc issue.

cheers,
  Sam
