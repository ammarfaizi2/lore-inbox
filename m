Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbVL0IKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbVL0IKT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 03:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbVL0IKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 03:10:18 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:3158 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932260AbVL0IKR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 03:10:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FSRMxiqbWU06zNZs+raNVCrdhb2wXqRX24ichLccU4R7BBi9sILRYbqf/vqa23cUTHZcaZ/98Y2ZkeNt2MB5htDYy9wVUhePhudbZwGxD3Qbw8raZ2MSr4F2S1zXrV0s6eLPQZX4RPIPeT02uxjTcFbTQmLtETk/+y8vXEqjcbE=
Message-ID: <f0309ff0512270010g39d42f83rf9da794f455854a5@mail.gmail.com>
Date: Tue, 27 Dec 2005 13:10:16 +0500
From: Nauman Tahir <nauman.tahir@gmail.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: ia_64_bit Performance difference
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1135669831.2926.11.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <f0309ff0512262318r6d06292u7b151f2608b286cf@mail.gmail.com>
	 <1135669831.2926.11.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/05, Arjan van de Ven <arjan@infradead.org> wrote:
> On Tue, 2005-12-27 at 12:18 +0500, Nauman Tahir wrote:
> > Hi all,
> > I have written a block device driver. Driver includes the
> > implementation of write back cache policy. Purpose of the driver is
> > not an issue. The problem I am facing is the considerable difference
> > of performance when I run same driver on 32 and 64 BIT OS. I am
> > testing the driver on 64 Bit Machine and run the same driver on both
> > (32 and 64 Bit) OS. On 32 Bit, IO rate is almost double then on 64 Bit
> > OS. ( i wish it could have been opposite :( )
>
> you forgot to post the URL to your source code...

I did NOT FORGET to post the URL of my code as I mentioned I am
interested in general
areas of the kernel to look for. Like is there any problem related to
64 bit specific kernel compilation etc...

You should ask for my system configurations. As far as the code is
concered there is not any architecture specific issue I guess in that.
I have used threads of MD as my generic thread library and have used
calculations based on unsigned long.

Kernel Version:
I am using is 2.6.9 and onwards.

Machine configuration is :
HP Prolient DL 145 (Dual Opteron 244 Processors with 14GB RAM)

Regards

Nauman
