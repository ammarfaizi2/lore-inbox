Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbWBZMZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWBZMZb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 07:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbWBZMZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 07:25:31 -0500
Received: from nproxy.gmail.com ([64.233.182.196]:28060 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750773AbWBZMZa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 07:25:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aA/EaIZ/WVjIxqC1h8D92/Qv698tM7rHP4LtkDv7NwtFRHdWJFWleXKm8FctwN/O3SGBP+3RUPPbfeGXKuuRzjAIctpyGh9Ipt+Mo1aoBSmWQsbCIFaIaAf12Q7FdnCw2oP95Lmov44Hc6ht1STzk3sIFD0JfwQTuIiHceMnXIY=
Message-ID: <84144f020602260425p70fc4c5cn6de8dd6aa8a876d7@mail.gmail.com>
Date: Sun, 26 Feb 2006 14:25:25 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Victor Porton" <porton@ex-code.com>
Subject: Re: New reliability technique
Cc: "Avi Kivity" <avi@argo.co.il>, linux-kernel@vger.kernel.org,
       "Jesper Juhl" <jesper.juhl@gmail.com>
In-Reply-To: <E1FDKB1-0001GK-00@porton.narod.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4400B562.6020203@argo.co.il> <E1FDKB1-0001GK-00@porton.narod.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/06, Victor Porton <porton@ex-code.com> wrote:
> Isn't it better to double check (especially after such risky things as
> e.g. software suspend)?
>
> We need to check not only for damaged hardware, but also for
> kernel/modules bugs. For this ECC and cache reliability is useless.

What kernel bugs do you want to catch with double-checking free
memory? For use-after-free, we already have slab poisoning.

                                    Pekka
