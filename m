Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264401AbTLQLhq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 06:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264405AbTLQLhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 06:37:46 -0500
Received: from smtp06.iddeo.es ([62.81.186.16]:5838 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S264401AbTLQLho (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 06:37:44 -0500
Date: Wed, 17 Dec 2003 12:37:42 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: gcc-3.3.2 vs 2.6.0-test11
Message-ID: <20031217113742.GC2074@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all..

Are there any known issues wrt gcc-3.3.2 ?
I built test11 with gcc-3.3.1 and worked fine, the same config built with
3.3.2 does not pass init launch:

INIT version 2.85 booting

and nothing more....

I have to check, but I think it also miscompiles 2.4. I rebuilt a kernel on a
remote box (2.4.23 + assorted patches), that worked fine under 3.3.1, and
after reboot the box didn't came to life, no ping.

TIA

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (Cooker) for i586
Linux 2.6.0-test11-jam2 (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-4mdk))
