Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132825AbRDXGgc>; Tue, 24 Apr 2001 02:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132829AbRDXGgX>; Tue, 24 Apr 2001 02:36:23 -0400
Received: from ns2.Deuroconsult.com ([193.226.167.164]:2053 "EHLO
	marte.Deuroconsult.com") by vger.kernel.org with ESMTP
	id <S132825AbRDXGgO>; Tue, 24 Apr 2001 02:36:14 -0400
Date: Tue, 24 Apr 2001 09:37:17 +0300 (EEST)
From: Catalin BOIE <util@deuroconsult.ro>
To: linux-kernel@vger.kernel.org
Subject: disable_irq don't work corectly (ps2/kbd related)
Message-ID: <Pine.LNX.4.20.0104240918240.2993-100000@marte.Deuroconsult.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, guys!

I made a module that in init_module issue a "disable_irq (1)" and in
remove_module "enable_irq (1)".

Of course that I connect from the network to remove the module :))

This module don't works as expected. It disables the keyboard and the PS/2
mouse (irq 12)! Not from the beggining. After I insert the module, the
mouse works till I press a key.

What can be the problem?

Thank you very much!

---
Catalin(ux) BOIE
catab@deuroconsult.ro
A new Linux distribution: http://l13plus.deuroconsult.ro
http://www2.deuroconsult.ro/~catab


