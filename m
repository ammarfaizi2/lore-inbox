Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271288AbRHTPM3>; Mon, 20 Aug 2001 11:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271286AbRHTPMU>; Mon, 20 Aug 2001 11:12:20 -0400
Received: from mx2.port.ru ([194.67.57.12]:61448 "EHLO mx2.port.ru")
	by vger.kernel.org with ESMTP id <S271283AbRHTPMC>;
	Mon, 20 Aug 2001 11:12:02 -0400
From: "Samium Gromoff" <_deepfire@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: drivers/sound/adlib_card.c isn`t needed?
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [195.34.27.172]
Reply-To: "Samium Gromoff" <_deepfire@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E15YqiZ-000AAJ-00@f10.mail.ru>
Date: Mon, 20 Aug 2001 19:11:55 +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    some time ago i`ve posted patch to fix adlib 
  module region leak. the patch got rejected, but
  somewhat later i`ve completely realised the 
  ridiculousness of the existence of this code.

    why does adlib_card.c still exists?
  AFAICS its an wrapper to opl3 functions which ones
  fully support adlib (opl1).

  i think it`s even argued that x_ADLIB config option
  should exist, because it adds nothing more than
  this wrapper (in fact it even depends on opl3.h)...

  so i think the solution is to completely remove
  "adlib support"...

  am i wrong?

---


cheers,


   Samium Gromoff
