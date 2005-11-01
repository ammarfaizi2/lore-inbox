Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964942AbVKABsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942AbVKABsM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 20:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964943AbVKABsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 20:48:12 -0500
Received: from mailrly08.isp.novis.pt ([195.23.133.218]:27868 "EHLO
	mailrly08.isp.novis.pt") by vger.kernel.org with ESMTP
	id S964942AbVKABsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 20:48:11 -0500
Message-ID: <4366C95B.1040400@vgertech.com>
Date: Tue, 01 Nov 2005 01:48:11 +0000
From: Nuno Silva <nuno.silva@vgertech.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Knecht <markknecht@gmail.com>
CC: Lee Revell <rlrevell@joe-job.com>, "K.R. Foley" <kr@cybsft.com>,
       lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.14-rt1 - xruns in a certain circumstance
References: <5bdc1c8b0510301828p29ea517ew467a5f6503435314@mail.gmail.com>	 <50256.192.249.47.11.1130771450.squirrel@webmail2.pair.com>	 <5bdc1c8b0510310726t105f8f8emd1d044f760a8a1eb@mail.gmail.com>	 <1130776760.32101.40.camel@mindpipe> <5bdc1c8b0510311522r530eefbfmf15b860ac8352824@mail.gmail.com>
In-Reply-To: <5bdc1c8b0510311522r530eefbfmf15b860ac8352824@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Knecht wrote:

[..]

> I took a quick look. If you get a chance where does the NoAccel option
> go? Inside of the section for the radeon driver? I'm sure I can find
> this online but won't have much of an opportunity for the next few
> hours.

IMHO this wont matter because, IIRC, the preview window in mythtv 
doesn't even use xv... It's a straight x11 bitmap beeing drawn, after 
scaling (so it's very CPU intensive... It's like having the HDD without 
DMA enabled).

If the -rt series should work alright without DMA in the disks or with 
mplayer -vo x11 or with myth's preview it's another issue :-)

Btw, test for xruns with "mplayer -vo x11 movie.mpg" if you can.

Regards,
Nuno Silva
