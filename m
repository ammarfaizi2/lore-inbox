Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbUDHKgV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 06:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbUDHKgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 06:36:21 -0400
Received: from main.gmane.org ([80.91.224.249]:27617 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261606AbUDHKgT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 06:36:19 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
Subject: Re: cat /dev/hdb > /dev/null DoS
Date: Thu, 08 Apr 2004 12:36:11 +0200
Message-ID: <c539ur$h5e$1@sea.gmane.org>
References: <20040408085518.B4607@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: holmes.cs.upb.de
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
In-Reply-To: <20040408085518.B4607@beton.cybernet.src>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I did cat /dev/hdb > /dev/null and after a while (5 minutes),
> the system went totally unresponsive:
> 
> 1) man top takes 3 minutes to display man page
> 2) Switching between console and X takes also a couple of minutes
> 3) top shows this:
> 
> Cpu(s):  1.4% us,  1.4% sy,  0.0% ni,  0.0% id,  0.0% wa, 97.3% hi,  0.0% si

i guess you have DMA enabled on /dev/hdb. I would expect, that the 
system is at least 50% idle

