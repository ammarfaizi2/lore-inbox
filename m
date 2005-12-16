Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbVLPAi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbVLPAi0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 19:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbVLPAi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 19:38:26 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:63891 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751219AbVLPAiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 19:38:25 -0500
Subject: Re: [2.6 patch] i386: always use 4k stacks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <Pine.LNX.4.61.0512152356190.13568@yvahk01.tjqt.qr>
References: <20051211180536.GM23349@stusta.de>
	 <Pine.LNX.4.61.0512152356190.13568@yvahk01.tjqt.qr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 16 Dec 2005 00:36:02 +0000
Message-Id: <1134693362.21906.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-12-15 at 23:57 +0100, Jan Engelhardt wrote:
> By chance, I read that windows modules used in ndiswrapper
> may require >4k-stacks. Will this become a problem?

For ndiswrapper to deal with internally. If you see the previous
'discussions' you'll see that is needed anyway as NT stacks are over 8K 

