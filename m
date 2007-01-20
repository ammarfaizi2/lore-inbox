Return-Path: <linux-kernel-owner+w=401wt.eu-S965353AbXATTop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965353AbXATTop (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 14:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965354AbXATTop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 14:44:45 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:57898 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965353AbXATToo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 14:44:44 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Fogh56gdjy/CwwmS4VIObD9iMzo4L9/MTZf2kWooQgPj/dyN1JHfP70AfaQ3P37l/xFD1vxh4nNvxxxqdlxtJootwPc4rEq6RCMNl8GgQQswr7GLujd2PENwXctL26z5uQ2Jup+m+w/SfdXwlFhbYsyxBYZP3R1+6zgEgCPjef8=
Message-ID: <8355959a0701201144x290362d8ja6cd5bc1408475da@mail.gmail.com>
Date: Sun, 21 Jan 2007 01:14:41 +0530
From: "Sunil Naidu" <akula2.shark@gmail.com>
To: "Willy Tarreau" <w@1wt.eu>
Subject: Re: Abysmal disk performance, how to debug?
Cc: "=?ISO-8859-1?Q?Ismail_D=F6nmez?=" <ismail@pardus.org.tr>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20070120180344.GA23841@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200701201920.54620.ismail@pardus.org.tr>
	 <20070120174503.GZ24090@1wt.eu>
	 <200701201952.54714.ismail@pardus.org.tr>
	 <20070120180344.GA23841@1wt.eu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/07, Willy Tarreau <w@1wt.eu> wrote:
> > > >
>
> It is not expected to increase write performance, but it should help
> you do something else during that time, or also give more responsiveness
> to Ctrl-C. It is possible that you have fast and slow RAM, or that your
> video card uses shared memory which slows down some parts of memory
> which are not used anymore with those parameters.

I did test some SATA drives, am getting these value for 2.6.20-rc5:-

[sukhoi@Typhoon ~]$ time dd if=/dev/zero of=/tmp/1GB bs=1M count=1024
1024+0 records in
1024+0 records out
1073741824 bytes (1.1 GB) copied, 21.0962 seconds, 50.9 MB/s

What can you suggest here w.r.t my RAM & disk?

> Willy

Thanks,

~Akula2
