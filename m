Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030506AbWEZHXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030506AbWEZHXd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 03:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030509AbWEZHXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 03:23:33 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:11166 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1030506AbWEZHXc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 03:23:32 -0400
Message-ID: <4476AC3B.5030704@aitel.hist.no>
Date: Fri, 26 May 2006 09:20:27 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Nathan Scott <nathans@sgi.com>, linux-xfs@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: XFS write speed drop
References: <Pine.LNX.4.61.0605190047430.23455@yvahk01.tjqt.qr> <20060522105326.A212600@wobbly.melbourne.sgi.com> <Pine.LNX.4.61.0605221308290.11108@yvahk01.tjqt.qr> <20060523084309.A239136@wobbly.melbourne.sgi.com> <Pine.LNX.4.61.0605231517330.25086@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0605231517330.25086@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
> Well as mentioned, -o nobarrier solved it, and that's it. I do not actually 
> need barriers (or an UPS, to poke on another thread), because power 
> failures are rather rare in Germany.
Then there are mistakes like someone stepping on the power
cord, pulling out the wrong one, drilling holes in the wall,
there are kernel crashes, there is lightning,
there is the possibility that some
component inside the box just breaks.

Helge Hafting

