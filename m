Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262448AbUCEKsf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 05:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262452AbUCEKsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 05:48:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:62870 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262448AbUCEKsc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 05:48:32 -0500
X-Authenticated: #4512188
Message-ID: <40485B02.4020604@gmx.de>
Date: Fri, 05 Mar 2004 11:48:34 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: linux-kernel <linux-kernel@vger.kernel.org>, Jason Cox <jpcox@iastate.edu>,
       Autar022@planet.nl
Subject: Re: nicksched v30
References: <4048204E.8000807@cyberone.com.au>
In-Reply-To: <4048204E.8000807@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> http://www.kerneltrap.org/~npiggin/v30.gz
> 
> Applies to kernel 2.6.4-rc1-mm2.
> Run X at about nice -10 or -15.
> Please report interactivity problems with the default scheduler
> before using this one etc etc.

So far i noticed:

with default scheduler:

When I run emerge sync (I am on gentoo) and finally the cache on disk 
gets updated (very heavy disk activity), default scheduler (in 
conjunction with cfq, haven' tried other) causes a schmall pause of 1-2 
seconds when I use my browser, ie mouse cursor is ok, but I cannot 
scroll for that time.

your scheduler: I tried it with the "love-sources", so maybe that patch 
"steel300" incorporated was already a bit outdated, but I dunno. It had 
the same version as above.  When I click on a link in thunderbird and it 
opens up in firefox (is started and just a new tab is created) the 
mouses stutters for a brief moment. This didn't happen with default 
scheduler. I dunno if above sympton happens with yours.

I haven't reniced X withy our patch. But I did it once and I didn't see 
much of a difference. (I dunno if the mouse stutter went away then...)

bye,

Prakash
