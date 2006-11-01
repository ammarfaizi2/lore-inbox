Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946911AbWKAP65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946911AbWKAP65 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 10:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946912AbWKAP65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 10:58:57 -0500
Received: from main.gmane.org ([80.91.229.2]:20379 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1946911AbWKAP64 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 10:58:56 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: sky2 driver causes kernel crash as of 2.6.18.1
Date: Wed, 1 Nov 2006 15:57:41 +0000 (UTC)
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <slrnekhhcg.2j1.olecom@flower.upol.cz>
References: <4548BF70.1060802@metricsystems.com>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: flower.upol.cz
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-11-01, John Clark wrote:
> I have been compiling kernels from 2.6.16.16 on to see if there is any 
> improvement
> in the Sky2 driver. The most recent official kernel version, 2.6.18.1, 
> as of 10/31/06
> seems to still have problems.
>
> The crash debug splat indicates that the transmit routine was being 
> executed when
> the final crash occured. But before the crash there were a series of 
> diagnostics from
> the driver:
>
> NETDEV WATCHDOG: eth4: transmit time out
> sky2 eth4: tx timeout
> sky2 hardware hung? flushing
>
> messages.
>
> Is there any better driver in a 'unstable' kernel that someone has 
> tested sufficiently?

Well, try "unstable" 2.6.19-rc4. I'm not sure, but bug may be related to
7bd656d12119708b37414bf909ab2995473da818

Although, there are some sky2 updates in future 2.6.18.2, maybe they
are related too.
____

