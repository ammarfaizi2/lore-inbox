Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbUKRSap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbUKRSap (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 13:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262837AbUKRSa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 13:30:27 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38299 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261862AbUKRS1h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 13:27:37 -0500
Message-ID: <419CE98B.2090304@pobox.com>
Date: Thu, 18 Nov 2004 13:27:23 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "John W. Linville" <linville@tuxdriver.com>, linux-kernel@vger.kernel.org,
       alan@redhat.com
Subject: Re: [patch 2.6.10-rc2] oss: AC97 quirk facility
References: <20041117163016.A5351@tuxdriver.com> <20041117145644.005e54ff.akpm@osdl.org>
In-Reply-To: <20041117145644.005e54ff.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> "John W. Linville" <linville@tuxdriver.com> wrote:
> 
>>Add a quirk facility for AC97 in OSS, and add a quirk list for the
>>i810_audio driver.
>>
>>Signed-off-by: John W. Linville <linville@tuxdriver.com>
>>---
>>This allows automatically "correct" behaviour for sound hardware w/
>>known oddities.  For example, many cards have the headphone and
>>line-out outputs swapped or headphone outputs only.
>>
>>The code is stolen shamelessly from ALSA, FWIW...
> 
> 
> Dumb question: why not just use the ALSA driver?


Until we actually remove the OSS drivers, it's sorta silly to leave them 
broken.

	Jeff, still using i810_audio...


