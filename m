Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbTLHXou (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 18:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbTLHXou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 18:44:50 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25746 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262009AbTLHXof
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 18:44:35 -0500
Message-ID: <3FD50CD6.3070808@pobox.com>
Date: Mon, 08 Dec 2003 18:44:22 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: VIA on-chip RNG and crypto...
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


VIA has publicly posted the docs for the 'xstore' and 'xcrypt' 
instructions in their processors:

	http://www.via.com.tw/en/viac3/c3.jsp

(grab "VIA Padlock {ACE|RNG} Programming Guide" down at the bottom)

'xstore' is an instruction that any program may use, to obtain entropy 
from the on-chip hardware source (RNG).  The in-kernel hw_random driver 
already supports this (though this support will be moved to the 
userspace rngd soon).  'xcrypt' provides on-chip AES encrypt and 
decrypt, similarly useable by any program.

They have also supported open source by providing docs and occasionally 
hardware to myself, Dave Jones, Alan, and others.  So, while it might 
appear this is a shameless plug :) I just really like the technology, 
and am never shy about promoting good hardware designs, and vendors that 
work with the open source community.

	Jeff



P.S. In the interest of full disclosure, neither VIA nor my employer 
prompted me to write this.


