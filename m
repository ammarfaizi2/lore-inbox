Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269664AbUINSiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269664AbUINSiH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 14:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269038AbUINS3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 14:29:34 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:11418 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S269704AbUINSSV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 14:18:21 -0400
Message-ID: <41473578.7000106@colorfullife.com>
Date: Tue, 14 Sep 2004 20:16:24 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg Edwards <edwardsg@sgi.com>
CC: Jesse Barnes <jbarnes@sgi.com>, paulmck@us.ibm.com,
       "Martin J. Bligh" <mbligh@aracnet.com>, hawkes@sgi.com,
       linux-kernel@vger.kernel.org, wli@holomorphy.com
Subject: Re: kernbench on 512p
References: <200408191216.33667.jbarnes@engr.sgi.com> <200408192016.10064.jbarnes@engr.sgi.com> <20040820155717.GF1243@us.ibm.com> <200408201324.32464.jbarnes@engr.sgi.com> <41265CCE.3070808@colorfullife.com> <20040910190153.GA32062@sgi.com> <4145E50E.2020300@colorfullife.com> <20040914175241.GI4178@sgi.com>
In-Reply-To: <20040914175241.GI4178@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Edwards wrote:

>Manfred,
>
>Lockstat output attached from 2.6.9-rc2 at 512p and 2.6.9-rc2 + your two
>remaining RCU patches at 512p.  kernbench was run without any arguments.
>
>The difference for RCU looks great.
>
>  
>
Which value did you use for RCU_GROUP_SIZE? I'm not sure what's the 
optimal value for 512p - probably 32 or so.

--
    Manfred
