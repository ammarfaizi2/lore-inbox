Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161970AbWLAVkd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161970AbWLAVkd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 16:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161976AbWLAVkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 16:40:33 -0500
Received: from py-out-1112.google.com ([64.233.166.177]:18377 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161970AbWLAVkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 16:40:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WZOCtoonM2bmrW6gvj2Un5XJwTuHwb6EXIwNydznAAcFHrrMS8MElF38QAeioh/ZfIQKmhkNL8/bkVXgoDLwqxXl3djGQHe94ZKpQovJf9NiEsFtKL6BqP4fzD5MFD/+hbApiZxLWqGcqg1q2WNKbmdap1SPSDzTPZ0JEZR+SPM=
Message-ID: <5d96567b0612011340m410a2294w9b02b619a62888da@mail.gmail.com>
Date: Fri, 1 Dec 2006 23:40:31 +0200
From: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: Re: slow io_submit
Cc: linux-aio@kvack.org, "Jens Axboe" <jens.axboe@oracle.com>
In-Reply-To: <20061201172749.GZ5400@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5d96567b0612010904s361b799t8db72accc287ca54@mail.gmail.com>
	 <20061201172749.GZ5400@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/06, Jens Axboe <jens.axboe@oracle.com> wrote:
> On Fri, Dec 01 2006, Raz Ben-Jehuda(caro) wrote:
> > Jens suparna hello
> >
> > I have managed to understand why io_submit is sometimes very slow.
> > It is because the device is plugged once too many io's are being sent.
> > I have conducted a simple test with nr_request to default value of 128
> > and and 256.
> > and it proved to be correct.
>
> I don't understand your email. The device is plugged when it is empty,
> not when it has emptied the request list.

first , i am not top posting you.
I made a mistake and associated plugging with a full queue.

> > I would truely appreciate your comment on this.
>
> On what? :-)
>
> If it's no blocking and returning EAGAIN instead, then I agree this is
> what should eventually happen.
Who returns EGAIN to whom ?   I am not sure i understand what you mean here.

> Right now nobody is working on that
> afaik, so it's not something that will hit the next kernel.

thank you
raz

> --
> Jens Axboe
>
>


-- 
Raz
