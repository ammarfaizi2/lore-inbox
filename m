Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbVHRRHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbVHRRHU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 13:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbVHRRHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 13:07:20 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:15264 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932314AbVHRRHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 13:07:19 -0400
Subject: Re: [rfc][patch] API for timer hooks
From: Lee Revell <rlrevell@joe-job.com>
To: Stas Sergeev <stsp@aknet.ru>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4304BE76.5090003@aknet.ru>
References: <42FDF744.2070205@aknet.ru>
	 <1124126354.8630.3.camel@cog.beaverton.ibm.com> <43024ADA.8030508@aknet.ru>
	 <1124244580.30036.5.camel@mindpipe> <430363F2.7090009@aknet.ru>
	 <1124296844.3591.7.camel@mindpipe> <430376B8.9040404@aknet.ru>
	 <1124320620.3591.14.camel@mindpipe>  <4304BE76.5090003@aknet.ru>
Content-Type: text/plain
Date: Thu, 18 Aug 2005 13:07:15 -0400
Message-Id: <1124384836.5973.16.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.7 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-18 at 20:59 +0400, Stas Sergeev wrote:
> The only limitation would be that when the
> speaker driver is enabled in the config,
> the ability to manually select the CONFIG_HZ
> will be lost, but maybe it is not that bad
> at all 

CONFIG_HZ is just a short term hack to placate people who insist on a
tick rate lower than 1000 but can't wait for dynamic tick to be ready.
Once dynamic tick is merged then CONFIG_HZ will need to go away.  We
don't impose arbitrary restrictions on the period of the soundcard
interrupt, I don't see why the PIT should be any different.

I would be quite disappointed if dynamic tick does not get merged for
2.6.14.

Lee


