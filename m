Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265909AbUJGNgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265909AbUJGNgs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 09:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269356AbUJGNgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 09:36:48 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:14487 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S265909AbUJGNgq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 09:36:46 -0400
Date: Thu, 7 Oct 2004 14:36:26 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@hibernia.jakma.org
To: Martijn Sipkema <msipkema@sipkema-digital.com>
cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       "David S. Miller" <davem@davemloft.net>, joris@eljakim.nl,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
In-Reply-To: <001c01c4ac76$fb9fd190$161b14ac@boromir>
Message-ID: <Pine.LNX.4.61.0410071432070.304@hibernia.jakma.org>
References: <Pine.LNX.4.58.0410061616420.22221@eljakim.netsystem.nl>
 <20041006080104.76f862e6.davem@davemloft.net> <Pine.LNX.4.61.0410061110260.6661@chaos.analogic.com>
 <20041006082145.7b765385.davem@davemloft.net> <Pine.LNX.4.61.0410061124110.31091@chaos.analogic.com>
 <Pine.LNX.4.61.0410070212340.5739@hibernia.jakma.org> <4164EBF1.3000802@nortelnetworks.com>
 <Pine.LNX.4.61.0410071244150.304@hibernia.jakma.org> <001601c4ac72$19932760$161b14ac@boromir>
 <Pine.LNX.4.61.0410071346040.304@hibernia.jakma.org> <001c01c4ac76$fb9fd190$161b14ac@boromir>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2004, Martijn Sipkema wrote:

> Any sane application would be written for the POSIX API as 
> described in the standard, and a sane kernel should IMHO implement 
> that standard whenever possible.

NB: I dont disagree with you.

Just the impression I get is that there is no way to avoid this 
situation without a serious performance impact, and that the 
optimisation shouldnt really any affect any healthy app. (any which 
are really should be setting O_NONBLOCK).

If you could follow the spec without significantly harming 
performance, then I'd agree spec should be followed.

I dont really have anything useful to say other than that, IMHO, a 
sane app should be using O_NONBLOCK if it really does not want to 
block, so I shall now quietly back away from this thread.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
What this country needs is a good five cent microcomputer.
