Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132553AbRDWXN0>; Mon, 23 Apr 2001 19:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132540AbRDWXMV>; Mon, 23 Apr 2001 19:12:21 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:46097 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S132561AbRDWXKW>;
	Mon, 23 Apr 2001 19:10:22 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH 2.4.4.3: 3rdparty driver support for kbuild 
In-Reply-To: Your message of "Mon, 23 Apr 2001 19:03:45 -0400."
             <3AE4B4D1.A4A17FD6@mandrakesoft.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 24 Apr 2001 09:10:16 +1000
Message-ID: <13243.988067416@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Apr 2001 19:03:45 -0400, 
Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
>Keith Owens wrote:
>> On Sun, 15 Apr 2001 05:25:24 -0400,
>> Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
>> >The attached patch, against kernel 2.4.4-pre3, adds a feature I call
>> >"3rd-party support."
>> 
>> Already covered by my 2.5 makefile rewrite[1] which has explicit
>> support for third party kernel source.
>
>I don't see how multiple source trees can be merged automatically with
>100% accuracy.  

I agree, multiple source trees only work 100% for non-overlapping code.
It does not matter how you implement separate source, the moment it
overlaps you need human intervention.  That is true for my makefile-2.5
as well as your Perl method.

