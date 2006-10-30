Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965334AbWJ3RJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965334AbWJ3RJl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 12:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965349AbWJ3RJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 12:09:41 -0500
Received: from smtp-out.google.com ([216.239.45.12]:8010 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S965334AbWJ3RJk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 12:09:40 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=QSs37G33Ssw2Q71XE3GNKnlnFheyA2PfMrC/wpqC9PIE0dfJamXwisFRQkJoOgwo/
	9zVWWl39HgwJ4W3qsTojA==
Message-ID: <454631C1.5010003@google.com>
Date: Mon, 30 Oct 2006 09:09:21 -0800
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Andy Whitcroft <apw@shadowen.org>, linux-kernel@vger.kernel.org,
       Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-rc3-mm1 -- missing network adaptors
References: <20061029160002.29bb2ea1.akpm@osdl.org>	<45461977.3020201@shadowen.org>	<45461E74.1040408@google.com> <20061030084722.ea834a08.akpm@osdl.org>
In-Reply-To: <20061030084722.ea834a08.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Setting up network interfaces:
>>      lo
>>     lo        IP address: 127.0.0.1/8
>>7[?25l[1A[80C[10D[1;32mdone[m8[?25h    eth0
>>               No configuration found for eth0
>>7[?25l[1A[80C[10D[1munused[m8[?25h    eth1
>>             No configuration found for eth1
>>
>>for all 8 cards.
> 
> 
> What version of udev is being used?

Buggered if I know. If we could quit breaking it, that'd be good though.
If it printed its version during boot somewhere, that'd help too.

> Was CONFIG_SYSFS_DEPRECATED set?

No.

M.
