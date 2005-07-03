Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261512AbVGCUDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbVGCUDh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 16:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbVGCUDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 16:03:37 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:35547 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S261512AbVGCUDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 16:03:32 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <42C84478.2020302@s5r6.in-berlin.de>
Date: Sun, 03 Jul 2005 22:03:04 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Reply-To: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
CC: =?ISO-8859-1?Q?Rog=E9rio_Brito?= <rbrito@ime.usp.br>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Firewire/SBP2 and the -mm tree
References: <20050701044018.281b1ebd.akpm@osdl.org> <200507020005.04947.rjw@sisk.pl> <20050702031955.GC28251@ime.usp.br> <42C664CE.9020009@s5r6.in-berlin.de> <20050703053304.GA815@ime.usp.br> <20050703180455.GA1947@ime.usp.br>
In-Reply-To: <20050703180455.GA1947@ime.usp.br>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: (-1.556) AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogério Brito wrote:
> With 2.6.13-rc1-mm1, it works if I patch sbp2.[ch] *and* pass the
> disable_irm parameter. If I don't pass the parameter, I get the same
> strange behaviour as I did before.

Thanks for the systematic tests.

> I have not yet tested with a vanilla 2.6.13-rc1-mm1 (i.e., without patching
> sbp2.[ch]) and with disable_irm=1. I can test this, if desired or any other
> thing that you may want me to test.

We need to get it working without disable_irm. I hope to have some spare 
time sooner or later to look closer into it. I would get back to you if 
I come up with patches to try out or if somebody else proposes a fix.
-- 
Stefan Richter
-=====-=-=-= -=== ---==
http://arcgraph.de/sr/
