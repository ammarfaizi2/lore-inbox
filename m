Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289725AbSBJSlJ>; Sun, 10 Feb 2002 13:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289726AbSBJSlA>; Sun, 10 Feb 2002 13:41:00 -0500
Received: from [195.163.186.27] ([195.163.186.27]:49890 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S289725AbSBJSkx>;
	Sun, 10 Feb 2002 13:40:53 -0500
Date: Sun, 10 Feb 2002 20:40:35 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Laurence <laudney@21cn.com>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Transaction TCP patch for Linux
Message-ID: <20020210204035.M20396@mea-ext.zmailer.org>
In-Reply-To: <20020210164754Z289694-13996+20348@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020210164754Z289694-13996+20348@vger.kernel.org>; from laudney@21cn.com on Mon, Feb 11, 2002 at 12:50:02AM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2002 at 12:50:02AM +0800, Laurence wrote:
> I'd like to be emailed comments or replies personally.
> 
> Transaction TCP is an extension for TCP. Its performance advantage is
> indisputably better than standard TCP. But only FreeBSD integrates
> TTCP into its kernel. So, I've started T/TCP for Linux at
> http://ttcplinux.sourceforge.net or
> http://sourceforge.net/projects/ttcplinux. I'm writing the kernel
> patch for Linux kernel 2.4.2. Is anyone interested in it or have
> anything to say about T/TCP's pros and cons??

  http://theory.lcs.mit.edu/~mass/comm.html
  http://theory.lcs.mit.edu/~mass/forte96.html

  There Mark Smith shows that T/TCP does not (in all error cases)
  act the _same_ as TCP, although that does not necessarily mean
  it would be wrong.

  Reading  W.R.Stevens' book "TCP/IP Illustriated, Volume 3"
  gives a glimpse of how BSD did things in NET/3 code back
  in early 1994-1996, and there I see many odd bits like
  per-host route entires containing support data..


> Besides, I've finished some basic codes involving:
> 1. new structures
> 2. newly created or modified funtions mainly related to receiving
> 
> If anyone is interested, tell me and I'll send the codes. I don't want 
> to upload the codes in CVS at this moment. At least, I want to have a 
> basic but compile-able one.

/Matti Aarnio
