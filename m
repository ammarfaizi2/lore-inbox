Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932493AbWGMQcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbWGMQcJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 12:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbWGMQcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 12:32:09 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:3236 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932493AbWGMQcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 12:32:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=U8oVMd2yi6f4G9xwNk9GZTqHtN5tWl4tve5kQrYyTViwucueV0NnYpIvaAxAwtqmBV7iuIrwNEF+Qk5x0/etLD92tZJ5u0wWj/kAOLBty2GGSctNtjKbfpeT+bRjoOtBEt1ZJrtdGuCLlzZg6b7Tw3EtI81E6gXUDuqc2/DGhHg=
Message-ID: <5d96567b0607130932g7ba6cf0jfebdb0af9c933000@mail.gmail.com>
Date: Thu, 13 Jul 2006 19:32:07 +0300
From: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
To: linux-aio@kvack.org
Subject: Re: io_submit() taking a long time to return ?
Cc: "Xavier Roche" <roche+kml2@exalead.com>, linux-kernel@vger.kernel.org,
       "linux-aio Zach Brown" <zach.brown@oracle.com>
In-Reply-To: <44B66A70.90502@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44B5ED5F.1040606@exalead.com> <44B66A70.90502@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zach !!!
what do u means by "sync block mapping " ?

thank u
raz


On 7/13/06, Zach Brown <zach.brown@oracle.com> wrote:
> > By reading the aio documentation, we expected the io_submit call to
> > always return immediately,
>
> Sadly, that isn't guaranteed.
>
> > but in our preliminary tests we noticed that
> > sometimes this call can take a long time (more than 10 ms, even
> > sometimes more than 30 ms !!).
>
> If I had to guess I'd suspect that these delays are due to sync block
> mapping lookups in the submit path.  Do these tend to show up the first
> time you read a file?
>
> - z
>
> --
> To unsubscribe, send a message with 'unsubscribe linux-aio' in
> the body to majordomo@kvack.org.  For more info on Linux AIO,
> see: http://www.kvack.org/aio/
> Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
>


-- 
Raz
