Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262488AbSJPNhP>; Wed, 16 Oct 2002 09:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262492AbSJPNhO>; Wed, 16 Oct 2002 09:37:14 -0400
Received: from mx8.mail.ru ([194.67.57.18]:29967 "EHLO mx8.mail.ru")
	by vger.kernel.org with ESMTP id <S262488AbSJPNhO>;
	Wed, 16 Oct 2002 09:37:14 -0400
From: "Samium Gromoff" <_deepfire@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: [2.5.43]
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: 194.226.0.89 via proxy [194.226.0.63]
Date: Wed, 16 Oct 2002 17:42:45 +0400
Reply-To: "Samium Gromoff" <_deepfire@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E181oRh-0001FL-00@f12.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 looking at that i realise that DAC960 code in 2.5.43
is not supposed to be tested:
======
#error I am a non-portable driver, please convert me to use the Documentation/DMA-mapping.txt interfaces
======
 am i right?

the following weirdo appears in both gcc-3.1 and 3.2 (also in 2.5.42)
======
drivers/block/DAC960.c: In function `DAC960_DetectControllers':
drivers/block/DAC960.c:2465: `Controller' undeclared (first use in this function)
drivers/block/DAC960.c:2465: (Each undeclared identifier is reported only once
drivers/block/DAC960.c:2465: for each function it appears in.)

---
cheers,
   Samium Gromoff
______________________________________
_____________________________________

