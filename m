Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751647AbWJ2PmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647AbWJ2PmG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 10:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751651AbWJ2PmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 10:42:06 -0500
Received: from deine-taler.de ([217.160.107.63]:63693 "EHLO
	p15091797.pureserver.info") by vger.kernel.org with ESMTP
	id S1751647AbWJ2PmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 10:42:03 -0500
Message-ID: <4544CBC8.5090305@deine-taler.de>
Date: Sun, 29 Oct 2006 16:42:00 +0100
From: Uli Kunitz <kune@deine-taler.de>
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Daniel Drake <dsd@gentoo.org>
Cc: Holden Karau <holden@pigscanfly.ca>, zd1211-devs@lists.sourceforge.net,
       linville@tuxdriver.com, netdev <netdev@vger.kernel.org>,
       linux-kernel@vger.kernel.org, holdenk@xandros.com
Subject: Re: [PATCH] wireless-2.6 zd1211rw check against regulatory domain
 rather than hardcoded value of 11
References: <f46018bb0610231121s4fb48f88l28a6e7d4f31d40bb@mail.gmail.com>	 <453D48E5.8040100@gentoo.org> <f46018bb0610240709y203d8cdbw95cdf66db23aa1ce@mail.gmail.com> <453E2C9A.7010604@gentoo.org>
In-Reply-To: <453E2C9A.7010604@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Drake wrote:
> Holden Karau wrote:
>> I've changed the patch based on your suggestions :-)
> 
> Thanks, looks fine. Let's just wait for an OK from Ulrich, then you can 
> send it to John, without broken tabs/lines, with signoff and description.
> 
> Daniel

I'm not so sure about this. This patching might be US-specific and we 
cannot simply apply the setting for top channel of another domain 
instead of channel 11. One option would be to set the value only under 
the US regulatory domain.

Kind regards,

Uli

-- 
Uli Kunitz (kune@deine-taler.de)
