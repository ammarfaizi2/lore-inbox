Return-Path: <linux-kernel-owner+w=401wt.eu-S1750770AbWLXKVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWLXKVZ (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 05:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbWLXKVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 05:21:25 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:45792 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750770AbWLXKVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 05:21:24 -0500
Date: Sun, 24 Dec 2006 11:21:05 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: John Richard Moser <nigelenki@comcast.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: evading ulimits
In-Reply-To: <458DCCE2.3060605@comcast.net>
Message-ID: <Pine.LNX.4.61.0612241120370.16427@yvahk01.tjqt.qr>
References: <458C4CEF.3090505@comcast.net> <Pine.LNX.4.61.0612240111250.20280@yvahk01.tjqt.qr>
 <458DCCE2.3060605@comcast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 23 2006 19:42, John Richard Moser wrote:
>Jan Engelhardt wrote:
>> 
>> Note that trying to kill all shells is a race between killing them all first
>> and them spawning new ones everytime. To stop fork bombs, use killall -STOP
>> first, then kill them.
>
>Yes I know; the point, though, is that they should die automatically
>when the process count hits 4096.  They do with the first fork bomb;
>they keep growing with the second, well past what they should.

They don't just all die when you hit 4096. If you do nothing, 4096 +/- n will
stay around.


	-`J'
-- 
