Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276755AbRJPV5E>; Tue, 16 Oct 2001 17:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276759AbRJPV4z>; Tue, 16 Oct 2001 17:56:55 -0400
Received: from mail.courier-mta.com ([66.92.103.29]:30595 "EHLO
	mail.courier-mta.com") by vger.kernel.org with ESMTP
	id <S276755AbRJPV4l>; Tue, 16 Oct 2001 17:56:41 -0400
In-Reply-To: <fa.gl1qslv.d68lbj@ifi.uio.no>
In-Reply-To: <fa.gl1qslv.d68lbj@ifi.uio.no> 
From: "Sam Varshavchik" <mrsam@courier-mta.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Lockups with 2.4.12?
Date: Tue, 16 Oct 2001 21:57:12 GMT
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.3BCCAD38.00000870@ny.email-scan.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Kirby writes: 

> Has anybody else been seeing random lockups with 2.4.12?  We've seen a
> few servers stop responding and our backup server die nightly with
> 2.4.12, but 2.4.10pre10 seems to be fine.  I was only at the console once
> where I could actually see Oopses, but the scrollback overflowed with
> Oopses so I couldn't find the first one.  Nothing was saved to disk.  The
> stack trace of the oldest Oops I could find showed a program in
> sys_rt_sigaction. 
> 
> I'll try to track this down a bit more, I'm just wondering if anybody
> else is having similar problems.

I've had a similar problem which turned out to be a bug in the SMP ioapic 
code.  If those boxes of yours are SMP boxes, try booting with noapic. 

-- 
Sam 

