Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261740AbVAIU1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbVAIU1k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 15:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbVAIU1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 15:27:39 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:52407 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S261740AbVAIU1c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 15:27:32 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None, usuallly detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: printf() overhead
Date: Sun, 9 Jan 2005 15:27:30 -0500
User-Agent: KMail/1.7
Cc: John Richard Moser <nigelenki@comcast.net>
References: <41E18522.7060004@comcast.net>
In-Reply-To: <41E18522.7060004@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501091527.30977.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [151.205.52.185] at Sun, 9 Jan 2005 14:27:32 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 January 2005 14:25, John Richard Moser wrote:
>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>using strace to run a program takes aeons.  Redirecting the output
> to a file can be a hundred times faster sometimes.  This raises
> question.
>
>I understand that output to the screen is I/O.  What exactly causes
> it to be slow, and is there a possible way to accelerate the
> process? - --

As to what causes the slow, well fonts have to be rendered, and the 
screen has to be scrolled, both of which take finite pieces of time.
Displaying the file later just shifts the rendering etc time to 
something thats not nearly so noticeable because you can't read that 
fast anyway...

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.31% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
