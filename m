Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265176AbTFRMFU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 08:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265178AbTFRMFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 08:05:20 -0400
Received: from sophia.inria.fr ([138.96.64.20]:9673 "EHLO sophia.inria.fr")
	by vger.kernel.org with ESMTP id S265176AbTFRMFQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 08:05:16 -0400
Subject: 2.4.20 kernel, 4Go Ram, swap size recommendation ?
From: Nicolas Turro <Nicolas.Turro@sophia.inria.fr>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: INRIA
Message-Id: <1055938752.2310.209.camel@atlas.inria.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 18 Jun 2003 14:19:12 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, we have a bunch of Pcs here with 4 Go of ram.
In the old times, setting a swap file twice as big as the
physical ram was the rule i followed.
In the begining of 2.4 series this rule was mandatory.
What is the current 'usage' speaking of swapfile size ?

We have big disks (80Go) so 8go of swap is not a problem
but is-it necessary ? Realistic ?
Most of our machines will be used as desktop, with kde env
+ dev tools AND will sometime run ONE BIG process.. (mathlab,
custom computation). I think that each process cannot be 
bigger than 3 Go ? plus, let say, an overhead of.. 2 Go for the env
(X server/kde), totalling 5 Go of total memory space needed...
4 Go of physram + 8 Go swap seems useless...
Any thoughts ?

-- 
Nicolas Turro <Nicolas.Turro@sophia.inria.fr>
INRIA

