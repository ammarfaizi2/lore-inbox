Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbVAWSFc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbVAWSFc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 13:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVAWSFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 13:05:32 -0500
Received: from smtpout4.uol.com.br ([200.221.4.195]:11263 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S261194AbVAWSF1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 13:05:27 -0500
Date: Sun, 23 Jan 2005 16:05:51 -0200
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: linux-kernel@vger.kernel.org
Subject: Re: ppp in 2.6.11-rc2 Badness in local_bh_enable at kernel/softirq.c
Message-ID: <20050123180551.GB7077@ime.usp.br>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <41F35FAB.1050304@netikka.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41F35FAB.1050304@netikka.fi>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 23 2005, Johnny Strom wrote:
> I have the same problem with 2.6.11-rc2 I am using ppp with rp-pppoe-3.5 
> it starts like this as soon as it brings upp the link.

I am also seeing this "Badness in local_bh_enable at kernel/softirq.c:140"
message spamming my logs. It is quite scary, might I add. I have only seen
it with 2.6.11-rc2.

Aside from that, the system seems to be working fine, but I only noticed
this message for the last few hours. Before that, I run kernel 2.6.11-rc2
for 2 days straight and didn't see anything like that.

It seems to have started when I first loaded the netfilter modules. I can
provide more information. Just let me know what would be desired and I'll
try to get it.


Hope this helps, Rogério Brito.

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogério Brito - rbrito@ime.usp.br - http://www.ime.usp.br/~rbrito
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
