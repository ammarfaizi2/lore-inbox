Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbWIVHYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbWIVHYd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 03:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWIVHYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 03:24:33 -0400
Received: from fbxmetz.linbox.com ([81.56.128.63]:26079 "EHLO
	fbxmetz.linbox.com") by vger.kernel.org with ESMTP id S1750831AbWIVHYc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 03:24:32 -0400
Message-ID: <45138FAC.30700@linbox.com>
Date: Fri, 22 Sep 2006 09:24:28 +0200
From: Ludovic Drolez <ludovic.drolez@linbox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20060628 Debian/1.7.8-1sarge7.1
X-Accept-Language: fr, en-us, en
MIME-Version: 1.0
To: Vincent Pelletier <vincent.plr@wanadoo.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched.c: Be a bit more conservative in SMP
References: <200609031541.39984.subdino2004@yahoo.fr> <69304d110609191050w777a5c48ibe84bc0e3ce65df3@mail.gmail.com> <4510F0FD.4060602@linbox.com> <200609212036.24856.vincent.plr@wanadoo.fr>
In-Reply-To: <200609212036.24856.vincent.plr@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent Pelletier wrote:
> Maybe I was completely wrong with my assumption that one running process 
> always has an impact of 1, which would have make the scheduler underestimate 
> the load on one cpu and put too many processes on it, without moving them 
> afterward.

Yes, maybe that's the problem, since in my bench, one process takes only 40% of 
the CPU.

Cheers,

-- 
Ludovic DROLEZ                              Linbox / Free&ALter Soft
www.linbox.com www.linbox.org	              tel: +33 3 87 50 87 90
152 rue de Grigy - Technopole Metz 2000                   57070 METZ
