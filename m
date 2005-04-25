Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbVDYVyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbVDYVyM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 17:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbVDYVyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 17:54:12 -0400
Received: from smtprelay04.ispgateway.de ([80.67.18.16]:40928 "EHLO
	smtprelay04.ispgateway.de") by vger.kernel.org with ESMTP
	id S261235AbVDYVyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 17:54:07 -0400
Date: Mon, 25 Apr 2005 23:54:08 +0200
From: Florian Engelhardt <flo@dotbox.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12-rc2-mm3 and bttv -> kernel panic
Message-ID: <20050425235408.208edf38@discovery.hal.lan>
X-Mailer: Sylpheed-Claws 1.9.6cvs21 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

i tried to install a 2.6.12-rc2-mm3 kernel with bttv support and 
after restarting the machine, i got something like this:

bttv0: PLL 28636363 => 35469950 .. ok
Unable to handle kernel NULL pointer ...

Call trace:
msp 3400_init_module
do_init_calls
init
init
init
kernel_thread_helper
kernel_thread_helper


If i build the bttv support as a module and doing a modprobe bttv when
the system is up, it loads without problems.

And second one:
Of course the nvidia-kernel module does not work right with the 2.6.12-
rc2-mm3 kernel. I can modprobe it, but if i try to start the X-Server,
it tells me, that it is unable to load the kernel module (allthough it
is allready loaded)

Kind regards

Florian Engelhardt

-- 
"I may have invented it, but Bill made it famous"
David Bradley, who invented the (in)famous ctrl-alt-del key combination
