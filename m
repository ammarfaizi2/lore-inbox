Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751411AbWICQad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbWICQad (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 12:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbWICQad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 12:30:33 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:6431 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751411AbWICQac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 12:30:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=Vh5AIUK1dBF16ZsCJTCd81O3PcutjypS83hDRKSWa8tdUiWNBYsRm33BpPHaoRImTFp61ohaS3yPJm4dE4+9+BIGyfFD1ooGLV6VmSEDwhXkZHMPzX9kSgfjZSRV7doK2IK9+1cSVbYwzy30v6hNq2uL9rurTuAeihLhL+gzAKI=
Message-ID: <7c3341450609030930h3b5d7edah5dc52049b9760004@mail.gmail.com>
Date: Sun, 3 Sep 2006 17:30:25 +0100
From: "Nick Warne" <nick@linicks.net>
To: "Bas Bloemsaat" <bas.bloemsaat@gmail.com>
Subject: Re: [PATCH] Vicam driver, device
Cc: mchehab@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <44FA9493.1090207@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <7c4668e50609021101j2b8c561er94d41ca95aca2b1b@mail.gmail.com>
	 <1157220743.15841.118.camel@praia>
	 <7c4668e50609030111i5f3cb079j76e9c8651cf8d6b4@mail.gmail.com>
	 <44FA9493.1090207@gmail.com>
X-Google-Sender-Auth: a968ce996751bbf9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/06, Bas Bloemsaat <bas.bloemsaat@gmail.com> wrote:
> Done. I put a line under the current one describing the cam it was developed for.
>
> And mailed the text without wrapping (thanks to Pavel for bringing that to my attention).
>
> Regards,
> Bas
>
> Description:
> Trivial patch to make Compro PS39U WebCam work with linux by using the vicam driver.
> The camera is just a vicam with another USB ID, so I added that ID to the driver, and it works now.

Do you get the release call back warning when rmmod the vicam module?
I tried to fix this ages ago, but all I successfully achieved was
kernel oops:

http://www.ussg.iu.edu/hypermail/linux/kernel/0510.3/1113.html

It would be nice to fix.

Nick

-- 
VGER BF report: U 0.495384
