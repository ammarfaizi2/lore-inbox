Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264567AbRFTC7S>; Tue, 19 Jun 2001 22:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264819AbRFTC7I>; Tue, 19 Jun 2001 22:59:08 -0400
Received: from sgi.SGI.COM ([192.48.153.1]:55658 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S264567AbRFTC7C>;
	Tue, 19 Jun 2001 22:59:02 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: John Weber <weber@nyc.rr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: How to compile on one machine and install on another? 
In-Reply-To: Your message of "Tue, 19 Jun 2001 22:23:47 -0400."
             <3B300933.2090807@nyc.rr.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 20 Jun 2001 12:58:30 +1000
Message-ID: <28123.993005910@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jun 2001 22:23:47 -0400, 
John Weber <weber@nyc.rr.com> wrote:
>On a related note... is System.map also necessary?  Anyone care to explain 
>what System.map does?  I have noticed that my kernel works with or 
>without that file, but just figured it was a good question to ask in 

Used by assorted user space utilities, ps, ksymoops, klogd and others.
It is not needed for booting, so its presence in /boot is a mistake.

