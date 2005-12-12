Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbVLLJGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbVLLJGV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 04:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbVLLJGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 04:06:21 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:18873 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751148AbVLLJGU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 04:06:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Qo5kWlDwHujbWj8H41KTmBh6qN0qtMkbN50l2pYF0G3oMmci6ex46MMayUMwMcZF8O/inEOJxVMBFlb/j8gZrO0kOijhVjfJGrS5e5UEYQVHB84EilkJxBZxMAABb2w0/e7Eria4x4+ivEprPr6A7x5xeLlSQgfNCBBAffgepSw=
Message-ID: <2f7228250512120106wc8f3f99n8633529da9f63f57@mail.gmail.com>
Date: Mon, 12 Dec 2005 14:36:19 +0530
From: Digvijoy Chatterjee <digvijoy.c@gmail.com>
Subject: Re: Errors while booting the newly built 2.6.12 kernel??
Cc: "Mukund JB." <mukundjb@esntechnologies.co.in>,
       linux-kernel@vger.kernel.org
In-Reply-To: <9a8748490512120022g3b5bba4ch3c2e13b4f1a08188@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3AEC1E10243A314391FE9C01CD65429B1BDB03@mail.esn.co.in>
	 <9a8748490512120022g3b5bba4ch3c2e13b4f1a08188@mail.gmail.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

may be you have to see if your basic console devices are being created
in initrd , things like /dev/console /dev/null you have to add that to
ur init script if its not

On 12/12/05, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 12/12/05, Mukund JB. <mukundjb@esntechnologies.co.in> wrote:
> >
> [snip]
> >
> I wrote a small guide a while back. Perhaps it can help you :
> http://www.linuxtux.org/~juhl/2.6-kernel-build.txt
>
>
> --
> Jesper Juhl <jesper.juhl@gmail.com>
> Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
> Plain text mails only, please      http://www.expita.com/nomime.html
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


--
Thanks and Regards
Digvijoy Chatterjee
