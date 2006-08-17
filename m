Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbWHQEvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbWHQEvI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 00:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWHQEvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 00:51:07 -0400
Received: from smtp-out.google.com ([216.239.45.12]:41833 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932247AbWHQEvF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 00:51:05 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=PVWT0zOd1/5UIpTfXWTDjBk92S4y4ZLn1mrRZaKzal18Nozz3Uve8lORC7ioj8575
	I7unRG74tgb1WPnpz+fjA==
Message-ID: <44E3F570.2020608@google.com>
Date: Wed, 16 Aug 2006 21:49:52 -0700
From: Daniel Phillips <phillips@google.com>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: Peter Zijlstra <a.p.zijlstra@chello.nl>,
       David Miller <davem@davemloft.net>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 0/9] Network receive deadlock prevention for NBD
References: <1155127040.12225.25.camel@twins> <20060809130752.GA17953@2ka.mipt.ru> <1155130353.12225.53.camel@twins> <20060809.165431.118952392.davem@davemloft.net> <1155189988.12225.100.camel@twins> <44DF888F.1010601@google.com> <20060814051323.GA1335@2ka.mipt.ru> <1155537943.5696.118.camel@twins> <20060814065454.GA6356@2ka.mipt.ru>
In-Reply-To: <20060814065454.GA6356@2ka.mipt.ru>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> On Mon, Aug 14, 2006 at 08:45:43AM +0200, Peter Zijlstra (a.p.zijlstra@chello.nl) wrote:
>>>Just pure openssh for control connection (admin should be able to
>>>login).
>>
>>These periods of degenerated functionality should be short and
>>infrequent albeit critical for machine recovery. Would you rather have a
>>slower ssh login (the machine will recover) or drive/fly to Zanzibar to
>>physically reboot the machine?
> 
> It will not work, since you can not mark openssh sockets as those which
> are able to get memory from reserved pool. So admin unable to check the
> system status and make anything to turn system's life on.

This is incorrect, please see my previous email.

Regards,

Daniel

