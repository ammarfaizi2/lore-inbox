Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbVFTOhf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbVFTOhf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 10:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVFTOhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 10:37:35 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:54123 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261263AbVFTOh0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 10:37:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Xn+PQH39Gmbso+rIcBZHvGAMT7d+Z1romDBbWt397rP3vT5xT8kPZkj84qGj4oKoPMY15YhVr8F4tIGtgeWzVDsqtV8+0bDvxfJIOTe8nSn0uEjNWKx9YNgflNej0ARpjcKGzdZ5t7hhM3+K8L98unoyWaTwwffAE0+zAYyE3us=
Message-ID: <405bb5a1050620073741a589f9@mail.gmail.com>
Date: Mon, 20 Jun 2005 16:37:23 +0200
From: Przemyslaw Sowa <sowa.przemyslaw@gmail.com>
Reply-To: Przemyslaw Sowa <sowa.przemyslaw@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Intercepting VFS calls
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frederik Deweerdt wrote:

> Le 20/06/05 12:37 +0200, Przemyslaw Sowa écrivit:
>  
>
>> Hello,
>>
>> I'd like to intercept VFS calls like read() and write() in 2.6
kernels but I'm new in kernel development and I don't know how to do
it.
>>
>> Could you help me, please?
>>
>>   
>
> You could have a look at kprobes.
> Regards,
> Frederik Deweerdt
>
>  
>
Thank you for the answer, but I need some way to execute my own
function (from a module) instead of read(), wrte()... and I don't want
to use any kernel patch. Is it possible?

Best regards,
Przemyslaw Sowa
