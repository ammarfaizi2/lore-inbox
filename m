Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262315AbVGWDfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262315AbVGWDfY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 23:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262325AbVGWDfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 23:35:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11660 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262315AbVGWDem (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 23:34:42 -0400
Date: Fri, 22 Jul 2005 20:31:22 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
cc: Alejandro Bonilla <abonilla@linuxwireless.org>,
       Blaisorblade <blaisorblade@yahoo.it>,
       LKML <linux-kernel@vger.kernel.org>, Andrian Bunk <bunk@stusta.de>,
       "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Giving developers clue how many testers verified certain kernel
 version
In-Reply-To: <1122088863.6510.19.camel@mindpipe>
Message-ID: <Pine.LNX.4.58.0507222029200.6074@g5.osdl.org>
References: <200507230244.11338.blaisorblade@yahoo.it>  <42E1986B.8070202@linuxwireless.org>
 <1122088160.6510.7.camel@mindpipe>  <42E1A832.7010604@linuxwireless.org>
 <1122088863.6510.19.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 22 Jul 2005, Lee Revell wrote:
> 
> Con's interactivity benchmark looks quite promising for finding
> scheduler related interactivity regressions.

I doubt that _any_ of the regressions that are user-visible are
scheduler-related. They all tend to be disk IO issues (bad scheduling or
just plain bad drivers), and then sometimes just VM misbehaviour.

People are looking at all these RT patches, when the thing is that most
nobody will ever be able to tell the difference between 10us and 1ms
latencies unless it causes a skip in audio.

		Linus
