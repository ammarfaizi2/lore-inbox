Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbVHQXRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbVHQXRD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 19:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbVHQXRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 19:17:03 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:4019 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751320AbVHQXRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 19:17:02 -0400
Subject: Re: [rfc][patch] API for timer hooks
From: Lee Revell <rlrevell@joe-job.com>
To: Stas Sergeev <stsp@aknet.ru>
Cc: john stultz <johnstul@us.ibm.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <430376B8.9040404@aknet.ru>
References: <42FDF744.2070205@aknet.ru>
	 <1124126354.8630.3.camel@cog.beaverton.ibm.com> <43024ADA.8030508@aknet.ru>
	 <1124244580.30036.5.camel@mindpipe> <430363F2.7090009@aknet.ru>
	 <1124296844.3591.7.camel@mindpipe>  <430376B8.9040404@aknet.ru>
Content-Type: text/plain
Date: Wed, 17 Aug 2005 19:16:59 -0400
Message-Id: <1124320620.3591.14.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.7 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-17 at 21:41 +0400, Stas Sergeev wrote:
> I guess now I realized how you (and Nish)
> assume I could use it: is it that I
> should set CONFIG_HZ to the value I
> need at compile-time, and just remove
> all the timer reprogramming from the
> driver in a hope the dynamic-tick patch
> will slow it down itself when necessary? 

The current implementations don't allow HZ to go higher than CONFIG_HZ
but that's the next logical step.

Lee

