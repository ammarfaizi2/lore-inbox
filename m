Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbVFYSWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbVFYSWR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 14:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbVFYSWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 14:22:12 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:14704 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261263AbVFYSUp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 14:20:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=E6bGY0J9RpzPxosHLVvVSHklOezxNjb4//uA4cI70yXhskMFpDirQB3WuTK58ug3NtiPEgT092ctSPeOUp4Qs1Xoppgp07pWyMfOwWjSK7FXWxvs305xrsU47PLDNRhMTxMDbPTK5zoqPOjGI3QFmC0CMPeA4UsCbuSn/vVaw4M=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Paolo Marchetti <natryum@gmail.com>
Subject: Re: [PATCH] cpufreq: ondemand+conservative=condemand
Date: Sat, 25 Jun 2005 22:26:49 +0400
User-Agent: KMail/1.7.2
Cc: Dave Jones <davej@codemonkey.org.uk>,
       kernel <linux-kernel@vger.kernel.org>
References: <cc27d5b105062508086939012a@mail.gmail.com>
In-Reply-To: <cc27d5b105062508086939012a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506252226.49598.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 June 2005 19:08, Paolo Marchetti wrote:
> 'condemand' - This driver adds a dynamic cpufreq policy governor.
> The governor does a periodic polling and 
> changes frequency based on the CPU utilization.
> The support for this governor depends on CPU capability to
> do fast frequency switching (i.e, very low latency frequency
> transitions). 
> This driver takes inspiration (and code) from the ondemand and
> conservative governors, it does fast scale down like ondemand
> and gradual scale up like conservative.

Just change defaults in conservative governor to make it more responsive.
