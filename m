Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265438AbRFVPAL>; Fri, 22 Jun 2001 11:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265439AbRFVPAC>; Fri, 22 Jun 2001 11:00:02 -0400
Received: from horsea.3ti.be ([212.204.244.41]:32527 "EHLO horsea.3ti.be")
	by vger.kernel.org with ESMTP id <S265438AbRFVO7q>;
	Fri, 22 Jun 2001 10:59:46 -0400
Date: Fri, 22 Jun 2001 16:59:36 +0200 (CEST)
From: Dag Wieers <dag@wieers.com>
X-X-Sender: <dag@horsea.3ti.be>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Should __FD_SETSIZE still be set to 1024 ?
Message-ID: <Pine.LNX.4.33.0106221631500.27761-100000@horsea.3ti.be>
User-Agent: Mutt/1.2.5i
X-Mailer: Evolution 0.10 (Tasmanian Devil)
Organization: IBM Belgium
X-Extra: If you can read this and Linux is your thing. Work for IBM Belgium/Linux !
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is there a reason for __FD_SETSIZE to be 1024 in
linux/posix_types.h and gnu/types.h ?
Why can't we increase this number by default ?

Shouldn't it be set to the real limit of the kernel ? (And let
applications define their own limit if there is a need for one ?)

PS The LKML faq remarks that increasing this can break select.
Is this still an issue ? Under what conditions ?

Thanks in advance,

--   dag wieers,  dag@wieers.com,  http://dag.wieers.com/   --
«Onder voorbehoud van hetgeen niet uitdrukkelijk wordt erkend»

