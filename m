Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270762AbTGNT3J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 15:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270766AbTGNT3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 15:29:08 -0400
Received: from sea2-f4.sea2.hotmail.com ([207.68.165.4]:10000 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S270762AbTGNT25
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 15:28:57 -0400
X-Originating-IP: [143.182.124.3]
X-Originating-Email: [dagriego@hotmail.com]
From: "David griego" <dagriego@hotmail.com>
To: jgarzik@pobox.com
Cc: alan@storlinksemi.com, linux-kernel@vger.kernel.org
Subject: Re: Alan Shih: "TCP IP Offloading Interface"
Date: Mon, 14 Jul 2003 12:43:44 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Sea2-F4kWkKEsEXlwM9000178d9@hotmail.com>
X-OriginalArrivalTime: 14 Jul 2003 19:43:44.0832 (UTC) FILETIME=[3C680C00:01C34A40]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Jeff Garzik wrote:
>Anything beyond basic host-only TOE adds massive complexity for very little 
>gain:  interfacing netfilter and routing code with a black box we _hope_ 
>will act properly sounds like suicide.
Keep most of this on the host, offload only performance path like the 
Alacritech TOE.

>All this is vague handwaving without supporting evidence.  So far we get 
>stuff like Internet2 speed records _without_ TOE.  And Linux currently 
>supports 10gige...  and hosts are just going to keep getting faster and 
>faster.

Intel Clusters and Network Storage Volume Platforms Lab reported that it 
takes about 1MHz to process 1Mbps on a PIII.  Using this rule of thumb (they 
showed it scaling from 400MHz to 800MHz) it would take 10GHz to process 
10Mbps.  Well you might say "what about multi-processers?"  This would be 
good for people that have multi-processors, but there is a large segment of 
embedded processors that are not going have SMP, or be at 10GHz anytime 
soon.  Besides that processing interrupts does not scale across MPs 
liniarly.  The truth is that communication speeds are outpacing processor 
speeds at this time.
David

>
>	Jeff
>
>
>

_________________________________________________________________
Help STOP SPAM with the new MSN 8 and get 2 months FREE*  
http://join.msn.com/?page=features/junkmail

