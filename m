Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751463AbWDYIm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbWDYIm3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 04:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbWDYIm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 04:42:28 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:51975 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S1751463AbWDYIm1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 04:42:27 -0400
Message-ID: <444DE0F0.8060706@argo.co.il>
Date: Tue, 25 Apr 2006 11:42:24 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Xavier Bestel <xavier.bestel@free.fr>
CC: "J.A. Magallon" <jamagallon@able.es>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>
Subject: Re: C++ pushback
References: <4024F493-F668-4F03-9EB7-B334F312A558@iomega.com>	 <mj+md-20060424.201044.18351.atrey@ucw.cz>	 <444D44F2.8090300@wolfmountaingroup.com>	 <1145915533.1635.60.camel@localhost.localdomain>	 <20060425001617.0a536488@werewolf.auna.net> <1145952948.596.130.camel@capoeira>
In-Reply-To: <1145952948.596.130.camel@capoeira>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Apr 2006 08:42:26.0092 (UTC) FILETIME=[2DBACEC0:01C66844]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xavier Bestel wrote:
> In the first case you know that exactely *one* kmalloc(GFP_KERNEL)
> occurs. In the second case you have to browse SuperBlock's constructor
> to check if it allocates things, needs to run with/without interrupts,
> PREEMPT, whatever... (not even talking about exceptions).
>   
That seems to be a case against writing functions.

Why is a C function acceptable where a C++ constructor isn't?

-- 
error compiling committee.c: too many arguments to function

