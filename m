Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267972AbRGVNKX>; Sun, 22 Jul 2001 09:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267975AbRGVNKO>; Sun, 22 Jul 2001 09:10:14 -0400
Received: from mx6.port.ru ([194.67.23.42]:57871 "EHLO mx6.port.ru")
	by vger.kernel.org with ESMTP id <S267972AbRGVNJ5>;
	Sun, 22 Jul 2001 09:09:57 -0400
From: "Samium Gromoff" <_deepfire@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Ahemm... Region Leak... Still...
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [195.34.30.64]
Reply-To: "Samium Gromoff" <_deepfire@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E15OIzf-000Hpg-00@f5.mail.ru>
Date: Sun, 22 Jul 2001 17:09:59 +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

  Hello there again, browsed thru 2.4.7 adlib_card.c
AND i realised that my patch to fix module region leak
wasnt applied.
 Not to say it ws very clean, but whether anybody
cares about adlib or not, region leak is still there
unfixed.
 Expl: module_init registers region,
       module_exit doesnt release it.

---


cheers,


   Samium Gromoff
