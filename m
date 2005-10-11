Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbVJKUzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbVJKUzW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 16:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbVJKUzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 16:55:22 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:46546 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750735AbVJKUzV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 16:55:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=svluE/NJuKYc5dXor/18DWI6S2hBa2PvWRbxkhs+OO5mB6hC9TxwCuZzFpxL6eRIbb1qvLvnTwOizWfBeokR+VT/PcXvG3KqOLchJA1rgi2qbqSBeHPTm6o5IJ21+/V1szKXEnpBGV4zzFplpvJJ1fcQTZHKSfgyDc7ZLEo3lxc=
Message-ID: <434C1F8E.6080405@gmail.com>
Date: Tue, 11 Oct 2005 22:24:46 +0200
From: Alon Bar-Lev <alon.barlev@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20051008)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brian Gerst <bgerst@didntduck.org>
CC: "Jonathan M. McCune" <jonmccune@cmu.edu>, linux-kernel@vger.kernel.org,
       Arvind Seshadri <arvinds@cs.cmu.edu>, Bryan Parno <parno@cmu.edu>
Subject: Re: using segmentation in the kernel
References: <434C1D60.2090901@cmu.edu> <434C2269.5090209@didntduck.org>
In-Reply-To: <434C2269.5090209@didntduck.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst wrote:
> Jonathan M. McCune wrote:
> 
>> Hello,
>>
> Why send the kernel back to the 2.0 days?  There is no valid reason for 
> doing this with they way x86 segmentation works, which is why it was 
> done away with in 2.1.
> 

But with segmentation you can set code to be read-only, 
disallow execution from stack, separate modules so that they 
will not affect kernel and more...

The main problem with segmentation is that it is x86 specific...

Best Regards,
Alon Bar-Lev.
