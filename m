Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbUKTGw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbUKTGw3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 01:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262746AbUKTGw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 01:52:29 -0500
Received: from zhabb.mics.msu.su ([158.250.28.142]:34537 "EHLO
	zhabb.mics.msu.su") by vger.kernel.org with ESMTP id S261693AbUKTGvh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 01:51:37 -0500
X-SMScore: 0
X-SMRecipient: linux-kernel@vger.kernel.org
From: Peter Volkov Alexandrovich <pvolkov@mics.msu.su>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6 and route nat. Now I know. It's dead.
Date: Sat, 20 Nov 2004 09:17:33 +0300
User-Agent: KMail/1.7.1
References: <200411191720.13423.pvolkov@mics.msu.su> <pan.2004.11.19.16.31.34.51328@altlinux.ru>
In-Reply-To: <pan.2004.11.19.16.31.34.51328@altlinux.ru>
Organization: GPI RAN
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411200917.33425.pvolkov@mics.msu.su>
X-OriginalArrivalTime: 20 Nov 2004 06:54:28.0750 (UTC) FILETIME=[C7B71AE0:01C4CECD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 November 2004 19:31, Sergey Vlasov wrote:
> On Fri, 19 Nov 2004 17:20:13 +0300, Peter Volkov Alexandrovich wrote:
> > Short question: Must "route nat", mentioned in ip-cref documentation
> > coming with iproute2 package, work with 2.6.9 kernel?
>
> Support for CONFIG_IP_ROUTE_NAT was removed from the kernel - it has been
> broken by some networking changes, and nobody bothered to fix it.
>
> See this thread in linux-netdev:
>
> http://marc.theaimsgroup.com/?l=linux-netdev&m=109582576330019&w=2
>
> You can use netfilter (iptables etc.) for NAT and more, but probably it
> will consume more resources than the old "route nat" code.

Thank you for your answer. It's really pity. It's very bad.

-- 

______________________________________

Volkov Peter, <pvolkov@mics.msu.su>
Moscow State University, Phys. Dep.
______________________________________

NO ePATENTS, eSIGN now on:
http://petition.eurolinux.org
and maybe this helps...

Linux 2.4.26-gentoo-r9 i686
Mobile Intel(R) Celeron(R) CPU 1.60GHz
