Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267737AbUGXMaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267737AbUGXMaK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 08:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265031AbUGXMaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 08:30:10 -0400
Received: from pop.gmx.de ([213.165.64.20]:42404 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267737AbUGXMaE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 08:30:04 -0400
X-Authenticated: #21910825
Message-ID: <41025646.6020108@gmx.net>
Date: Sat, 24 Jul 2004 14:29:58 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.6) Gecko/20040114
X-Accept-Language: de, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Lars_Hagstr=F6m?= <lars@update.uu.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: forcedeth on MSI K8N Neo Platinum
References: <40EC7FB1.4020906@update.uu.se>
In-Reply-To: <40EC7FB1.4020906@update.uu.se>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lars,

Lars Hagström schrieb:
> Hi linux-kernel and Carl-Daniel,
> 
> I have just put together a system with a MSI K8N Neo Platinum
> motherboard, and I've been having trouble getting the network up and
> running. The chipset is the NVIDIA nForce 3 250Gb.
> 
> I'm using gentoo, and have compiled kernel 2.6.7 (gentoo-dev-sources, if
> you're familiar with gentoo) with the forcedeth-bk4 and
> forcedeth_gigabig_try19 patches. I have compiled the forcedeth driver as
> a module (It is the 10/100 forcedeth driver that is patched to handle
> 1000, right?).
> When I try to start up the network I get the following messages in my
> syslog:
>   eth0: phy init failed to autoneg
>   eth0: no link during initialization
> (I had the NIC connected to a switch at the time, in case that is what
> is meant by the "no link" bit)
> Is there something simple that I missed, like module parameters, or is
> this a more complicated issue?
> 
> Tonight I will try to enable debugging in the code, to see if I can get
> some more information for you. I would be more than willing to help you
> out with any testing you need.

Could you please try Linux 2.6.8-rc2 without any driver patch? It has the
latest version of forcedeth and I am very interested in any bug reports/
side effects of the update.

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
