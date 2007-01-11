Return-Path: <linux-kernel-owner+w=401wt.eu-S1751410AbXAKTLg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbXAKTLg (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 14:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbXAKTLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 14:11:36 -0500
Received: from wr-out-0506.google.com ([64.233.184.239]:26972 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410AbXAKTLd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 14:11:33 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pTEj4odkS7UXMXepi/an318MUoxuPIyi9HWVY1gwIdjqwAiCusmbNjaBZEgR+P/c5FAclfRB58W3ckzlzB5wygT5n7MV76jOMbisDeTsHcaRct24ZIaEboz7oOSKrZXxCpqDRZTWKh35IsGj8qTdWGzLFCR6dM9FXowLaOp2UDk=
Message-ID: <13426df10701111111y57776285ma14b6effb236af58@mail.gmail.com>
Date: Thu, 11 Jan 2007 12:11:32 -0700
From: "ron minnich" <rminnich@gmail.com>
To: "Stefan Reinauer" <stepan@coresystems.de>
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
Cc: "OLPC Developer's List" <devel@laptop.org>,
       "Linux Kernel ML" <linux-kernel@vger.kernel.org>,
       "Mitch Bradley" <wmb@firmworks.com>
In-Reply-To: <20070111182041.GA6243@coresystems.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <13426df10701110939k21f7bb1dy38d2b34ca37a5a36@mail.gmail.com>
	 <20070111182041.GA6243@coresystems.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/07, Stefan Reinauer <stepan@coresystems.de> wrote:

> This works fine for just passing the device tree, but it will fail for
> the next step of being able to use the firmware in the OS, and returning
> sanely to the firmware.

And why is it we need to do that, presently? And how, in a virtualized
environment, for example, would you plan to support this calling into
firmware? (I sort of know how IBM does it, I am wondering how OFW
would plan to do it).

We can standardize passing a device tree structure across a very wide
range of environments. But supporting callbacks is necessarily going
to be a much smaller range of environments. It sounds, however, like
it will be possible to do both the callback and non-callback cases, so
I think I'm fine with that anyway. I will wait for Segher's patch.

thanks

ron
