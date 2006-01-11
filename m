Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbWAKOd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbWAKOd4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 09:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbWAKOd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 09:33:56 -0500
Received: from nproxy.gmail.com ([64.233.182.207]:31831 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932396AbWAKOdz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 09:33:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ieq0T/mimVw/E4vNyjgC99K/BspoejICcjJ+Zy/C2o/xYWoLpByLnGcQYnEORVhO2LK0uCDi5SloWv11tLrbzec42V8CIZP0acp9Omo/kfvkF3ow5YN9Ggp/GSXiqaR87PB6lSux7qx4vJeq8KbX4DSGwqjNtyvisD0VmTsunlg=
Message-ID: <728201270601110633i2eb8c71dq8a0c23d9e7ad724f@mail.gmail.com>
Date: Wed, 11 Jan 2006 08:33:20 -0600
From: Ram Gupta <ram.gupta5@gmail.com>
To: jeff shia <tshxiayu@gmail.com>
Subject: Re: something about disk fragmentation
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <7cd5d4b40601110501w40bc28f0peb13cdbb082e2b4a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7cd5d4b40601110501w40bc28f0peb13cdbb082e2b4a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6 kernel has  3 differen kind of io schedulers. Anticipatory io
scheduler is the default one. You may try to select CFQ  or deadline
scheduler & see if that improves your performance. These schedulers
have parameters which can be tuned also.

Regards
Ram Gupta

On 1/11/06, jeff shia <tshxiayu@gmail.com> wrote:
> Hello,everyone
>
>    In a file system ,the disk fragmentation can slow down the data accessing
> speed.How can I solve this kind of problem in a file system?I know that
> preallocation tech can do this.Is there any other solutions?
>   Thank you!
>
> Yours
> Jeff
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
