Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750742AbWFDQXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWFDQXh (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 12:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWFDQXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 12:23:37 -0400
Received: from wx-out-0102.google.com ([66.249.82.194]:46728 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750742AbWFDQXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 12:23:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KMMLPPdSZ4XzGYtqDeJJof1DuhE/KrnOvQJekU0+9bkeKlarhGcgCQWd0RuY/dqkMWDrXb+Dl2djgODJ0+rwbVMsBxSH+eCLL13/IxB1zPQ1pX8lzJyXqej8beZP+TLckJVZX03mAyDOFYjFJ5lHYF3oteJLZKGghqXKVipfYF4=
Message-ID: <beee72200606040923h670cf61dn22a61518ef94013f@mail.gmail.com>
Date: Sun, 4 Jun 2006 18:23:36 +0200
From: "davor emard" <davoremard@gmail.com>
To: "Alistair John Strachan" <s0348365@sms.ed.ac.uk>
Subject: Re: SMP HT + USB2.0 crash
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200606041706.28073.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <beee72200606040322w2960e5f9j1716addc39949ccb@mail.gmail.com>
	 <200606041706.28073.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Please attach another log without NVIDIA ever having being loaded. This is a
> technical forum, we need precise facts "nvidia has not been loaded", not
> vague recollections "nvidia probably wasn't loaded some time before".

that's not just a vague recollection: nvidia 7174 from debian's nvidia
legacy source
could not be even compiled and therefore also was certainly
not loaded for 2.6.16.19. But for this special occasion I am going to
reproduce this sucker on 2.6.16.19 once again with quite minimal
stuff compiled in. I can even connect serial cable and get a laptop
capture the bloody oops just to find out which kernel boot option is
for serial console :(

> Secondly, I highly recommend running memtest86 on your system for at least a
> couple of passes. You can download an ISO from the homepage and boot it from
> a CD. If this fails, you have faulty memory.

hmm I don't know why I didn't use memtest86. but I usually test memory on
new machine linux, by continuously gzip-ing and ungzip-ing
4GB file for 2 days and verify if the beginning
and the end file  are the same memory, CPU and a bit of
hardware handling them together should be good...
