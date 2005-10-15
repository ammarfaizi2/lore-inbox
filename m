Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbVJOHdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbVJOHdL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 03:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbVJOHdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 03:33:11 -0400
Received: from nproxy.gmail.com ([64.233.182.202]:3511 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751111AbVJOHdK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 03:33:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k3LFd7nmCtYw8L3hw8OQI1y1p7EPMeAzAYBb3Uhi/BoZlBooIHYopQz76EOibiYJrT7BEiEQhFN7VK1R538AtLxzsSL/thDmX0koBAUN5kJ3hbb47iKfHwjTmT1FIHW10ITXvhQChobCFkE5bLeuOVX9D0HoTpWc6yrQdiGnm04=
Message-ID: <2cd57c900510150033o7bd44608vdc57cb32e335b933@mail.gmail.com>
Date: Sat, 15 Oct 2005 15:33:09 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: li nux <lnxluv@yahoo.com>
Subject: Re: lock_kernel twice possible ?
Cc: linux <linux-kernel@vger.kernel.org>
In-Reply-To: <20051015070426.56781.qmail@web33314.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051015070426.56781.qmail@web33314.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/05, li nux <lnxluv@yahoo.com> wrote:
> Hi,
>
> I was going thru the NFS v3 code for SMP kernel 2.6.11
> to see how an inode gets revalidated. I found that
> there is a possibility that there may be an attempt to
> do lock_kernel() twice.
>
> Is this possible ? If yes then how this deadlock
> condition is/can be avoided.

The BKL is recursive!
--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
