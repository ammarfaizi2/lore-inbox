Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbVDRFfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbVDRFfY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 01:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbVDRFfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 01:35:24 -0400
Received: from [194.90.79.130] ([194.90.79.130]:9230 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S261680AbVDRFfS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 01:35:18 -0400
Message-ID: <4263470B.9000802@argo.co.il>
Date: Mon, 18 Apr 2005 08:35:07 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla Thunderbird 1.0.2-1 (X11/20050323)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: arjan@infradead.org, andihartmann@01019freenet.de,
       linux-kernel@vger.kernel.org
Subject: Re: More performance for the TCP stack by using additional hardware
 chip on NIC
References: <d3t63d$3qe$1@pD9F86D3F.dip0.t-ipconnect.de>	<1113728880.17394.16.camel@laptopd505.fenrus.org>	<1113733753.15803.26.camel@avik.scalemp> <20050417133620.04b4698d.davem@davemloft.net>
In-Reply-To: <20050417133620.04b4698d.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Apr 2005 05:35:17.0067 (UTC) FILETIME=[670A91B0:01C543D8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

>On Sun, 17 Apr 2005 13:29:14 +0300
>Avi Kivity <avi@argo.co.il> wrote:
>
>  
>
>>TOEs can remove the data copy on receive. In some applications (notably
>>storage), where the application does not touch most of the data, this is
>>a significant advantage that cannot be achieved in a software-only
>>solution.
>>    
>>
>
>You don't need to offload the TCP stack to make this case get
>zero-copy behavior.
>  
>
yes, Willy Tarreau outlined how buffering on the nic and splitting the 
dma can achieve zero copy.

are there any adapters out there which work this way?

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

