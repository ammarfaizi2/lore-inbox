Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbVDUNRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbVDUNRZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 09:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbVDUNRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 09:17:25 -0400
Received: from [62.206.217.67] ([62.206.217.67]:3014 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S261358AbVDUNRW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 09:17:22 -0400
Message-ID: <4267A7E1.7010904@trash.net>
Date: Thu, 21 Apr 2005 15:17:21 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Karsten Keil <kkeil@suse.de>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, linus@osdl.org
Subject: Re: fix for ISDN ippp filtering
References: <20050421130735.GA23653@pingi3.kke.suse.de>
In-Reply-To: <20050421130735.GA23653@pingi3.kke.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karsten Keil wrote:
> Hi,
> 
> We do not longer use DLT_LINUX_SLL for activ/pass filters but DLT_PPP_WITHDIRECTION
> witch need 1 as outbound flag.
> Please apply.

Won't this break compatibility with old ipppd binaries?

Regards
Patrick


