Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932626AbVLFTF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932626AbVLFTF3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 14:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932625AbVLFTF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 14:05:29 -0500
Received: from mail.dvmed.net ([216.237.124.58]:64407 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932623AbVLFTF1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 14:05:27 -0500
Message-ID: <4395E0E3.4040601@pobox.com>
Date: Tue, 06 Dec 2005 14:05:07 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Harald Welte <laforge@gnumonks.org>
CC: Dave Jones <davej@redhat.com>, Jiri Benc <jbenc@suse.cz>,
       Joseph Jezak <josejx@gentoo.org>, mbuesch@freenet.de,
       linux-kernel@vger.kernel.org, bcm43xx-dev@lists.berlios.de,
       NetDev <netdev@vger.kernel.org>
Subject: Re: Broadcom 43xx first results
References: <E1Eiyw4-0003Ab-FW@www1.emo.freenet-rz.de> <20051205190038.04b7b7c1@griffin.suse.cz> <4394892D.2090100@gentoo.org> <20051205195543.5a2e2a8d@griffin.suse.cz> <4394902C.8060100@pobox.com> <20051205195329.GB19964@redhat.com> <20051206151046.GF4038@rama.exocore.com>
In-Reply-To: <20051206151046.GF4038@rama.exocore.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Harald Welte wrote: > I also think that there is a lack
	of knowledge on the architecture of > 802.11 low-level protocols and
	drivers among many people (including > myself) in the network
	community. Only this way I can explain why there > are always people
	who claim that the kernel already has a 802.11 > 'stack'. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Welte wrote:
> I also think that there is a lack of knowledge on the architecture of
> 802.11 low-level protocols and drivers among many people (including
> myself) in the network community.  Only this way I can explain why there
> are always people who claim that the kernel already has a 802.11
> 'stack'.

This last sentence, regardless of the source, is simply playing with words.

We have 802.11 common code in the kernel, that several drivers are 
using.  Future drivers should modify that common code to suit their 
needs, rather than dropping it and starting from scratch.

	Jeff


