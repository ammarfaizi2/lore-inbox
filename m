Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261678AbSK0EXh>; Tue, 26 Nov 2002 23:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261693AbSK0EXh>; Tue, 26 Nov 2002 23:23:37 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3850 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261678AbSK0EXh>; Tue, 26 Nov 2002 23:23:37 -0500
Message-ID: <3DE44A78.9070602@zytor.com>
Date: Tue, 26 Nov 2002 20:30:48 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Dike <jdike@karaya.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: uml-patch-2.5.49-1
References: <200211270406.XAA04379@ccure.karaya.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike wrote:
> hpa@zytor.com said:
> 
>>Access control, ability to work in a chroot, ...
> 
> 
> Point.
> 
> 
>>For major/minor, this is presumably a misc device (major 10) or, if
>>you don't need module support, a kernel core device (major 1), and
>>write to device@lanana.org to have a minor number assigned. 
> 
> 
> If you think that this would be better as a misc device than a proc entry,
> then I can certainly go along with that.
> 

Absolutely.  I think /proc is heavily overused as a really bad devfs.

	-hpa



