Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbVERAgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbVERAgX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 20:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbVERAgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 20:36:23 -0400
Received: from lucidpixels.com ([66.45.37.187]:2688 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S262008AbVERAgQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 20:36:16 -0400
Date: Tue, 17 May 2005 20:36:15 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@localhost.localdomain
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Reproducible 2.6.11.9 NFS Kernel Crashing Bug!
In-Reply-To: <1116341217.21388.145.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.63.0505172036020.2028@localhost.localdomain>
References: <Pine.LNX.4.63.0505140911580.2342@localhost.localdomain>
 <1116341217.21388.145.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And I am using UDP, not TCP.

NFS Version 3.

On Tue, 17 May 2005, Alan Cox wrote:

> On Sad, 2005-05-14 at 14:18, Justin Piszcz wrote:
>> The mount options I am using are:
>> rw,hard,intr,rsize=65536,wsize=65536,nfsvers=3 0 0
>
> These are rather extreme r/wsizes especially if you are using UDP - I'm
> assuming this is TCP ?
>
>> Oh, and incase one may think there is a network issue, there is not,
>> during normal operation when I am not running dd, there are no network
>> problems, as shown below.
>
> I would certainly expect it to be a memory issue. Does it occur with
> 8192 as the size ?
>
