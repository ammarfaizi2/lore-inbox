Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132109AbRCVRBR>; Thu, 22 Mar 2001 12:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132101AbRCVRBI>; Thu, 22 Mar 2001 12:01:08 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:11538 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S132108AbRCVRA5>; Thu, 22 Mar 2001 12:00:57 -0500
Date: Thu, 22 Mar 2001 13:37:13 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: nbecker@fred.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: regression testing
In-Reply-To: <x88zoeeeyh8.fsf@adglinux1.hns.com>
Message-ID: <Pine.LNX.4.21.0103221334570.21415-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Mar 2001 nbecker@fred.net wrote:

> Hi.  I was wondering if there has been any discussion of kernel
> regression testing.  Wouldn't it be great if we didn't have to depend
> on human testers to verify every change didn't break something?

This is definately a great idea.  A relatively easy start should
be testing things like:
- automated crashme runs
- automated heavy stress testing
- automated compilation of the kernel with random config
  options (done by Arjan v/d Ven?)
- automated testing of certain kernel behaviour (didn't
  SGI have a project to look at this?  could they use help?)
- ... ?

Note that some of these testing options are almost trivial to
set up and could be run by any sysadmin with a few spare/test
machines. It would be great if testing like this could be done
on the Linux kernel.

If there isn't already some place to coordinate this testing,
I'll be able to host everything needed on NL.linux.org.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

