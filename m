Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932644AbVISWJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932644AbVISWJy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 18:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932672AbVISWJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 18:09:54 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:64704 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932644AbVISWJx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 18:09:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=nrNkHJpAfng481L0oY36SfNISkNzroCyK19Ie1g/tUKqSG6YWW36cx+1JqFvtg9a0PA1cWh/iWo3D2MOIoJb8pIWGnySTTjOVVBePRafM/7G1KWNFkh4o3Dz3YgVAeZOu8J3aPwd0EXvazYp+MQhvzECZIlWEpa/87UMoQWpAZk=
Message-ID: <432F36B4.8030209@gmail.com>
Date: Tue, 20 Sep 2005 06:07:48 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Dittmer <jdittmer@ppp0.net>
CC: Jurriaan <thunder7@xs4all.nl>, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: no cursor on nvidiafb console in 2.6.14-rc1-mm1
References: <20050919175116.GA8172@amd64.of.nowhere> <432F08C1.8010705@ppp0.net>
In-Reply-To: <432F08C1.8010705@ppp0.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Dittmer wrote:
> jurriaan wrote:
>> After updating from 2.6.13-rc4-mm1 to 2.6.14-rc1-mm1 I see no cursor on
>> my console.
> 
> Me too, 2.6.14-rc1-git4. Didn't try any kernel before with framebuffer,
> sorry. No fb options on the kernel command line.
> 

Can you try reversing this particular diff?

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blobdiff_plain;h=af99ea96012ec72ef57fd36655a6d8aaa22e809e;hp=30f80c23f934bb0a76719232f492153fc7cca00a

Tony


