Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbVLXW5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbVLXW5d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 17:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbVLXW5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 17:57:33 -0500
Received: from lucidpixels.com ([66.45.37.187]:934 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1750747AbVLXW5d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 17:57:33 -0500
Date: Sat, 24 Dec 2005 17:57:31 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: Jonathan Corbet <corbet@lwn.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Tape Drive Question (2.6.14.4) 
In-Reply-To: <20051224185458.8571.qmail@lwn.net>
Message-ID: <Pine.LNX.4.64.0512241757240.3510@p34>
References: <20051224185458.8571.qmail@lwn.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ahhh, ok thanks!

Justin.

On Sat, 24 Dec 2005, Jonathan Corbet wrote:

>> $ ls -l /dev/st0*
>> crw-rw-rw-  1 root tape 9,  0 2004-09-18 07:51 /dev/st0
>> crw-rw-rw-  1 root tape 9, 96 2004-09-18 07:51 /dev/st0a
>> crw-rw-rw-  1 root tape 9, 32 2004-09-18 07:51 /dev/st0l
>> crw-rw-rw-  1 root tape 9, 64 2004-09-18 07:51 /dev/st0m
>>
>> What differentiates st0 from a,l,m?
>> What does writing or reading to a tape using a,l,m signify?
>
> By default, they're all the same.  You can tweak the driver parameters,
> however, to cause the different devices to use different densities and
> blocking modes.  See mt(1) and Documentation/scsi/st.txt.
>
> jon
>
> Jonathan Corbet
> Executive editor, LWN.net
> corbet@lwn.net
>
