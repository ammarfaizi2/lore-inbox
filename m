Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268699AbUHTTbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268699AbUHTTbQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 15:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268688AbUHTTad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 15:30:33 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:61880 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S268662AbUHTT2d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 15:28:33 -0400
Message-ID: <41264F8F.6030608@colorfullife.com>
Date: Fri, 20 Aug 2004 21:22:55 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@engr.sgi.com>
CC: paulmck@us.ibm.com, "Martin J. Bligh" <mbligh@aracnet.com>, hawkes@sgi.com,
       linux-kernel@vger.kernel.org, wli@holomorphy.com,
       schwidefsky@de.ibm.com
Subject: Re: kernbench on 512p
References: <200408191216.33667.jbarnes@engr.sgi.com> <200408192016.10064.jbarnes@engr.sgi.com> <20040820155717.GF1243@us.ibm.com> <200408201324.32464.jbarnes@engr.sgi.com>
In-Reply-To: <200408201324.32464.jbarnes@engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes wrote:

>Looks like a bit more context has changed.  Manfred, care to respin against 
>-mm3 so I can test?
>
>  
>
No problem.
Btw, who removed rcu_restart_cpu: s390 must call it after changing 
nohz_cpu_mask. Otherwise a 32-bit wraparound will lead to false 
quiescent states.

--
    Manfred
