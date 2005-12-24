Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422663AbVLXKmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422663AbVLXKmE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 05:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422661AbVLXKmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 05:42:03 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:6599 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP id S932513AbVLXKl7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 05:41:59 -0500
Date: Sat, 24 Dec 2005 11:42:24 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: Joe Feise <jfeise@feise.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mouse issues in 2.6.15-rc5-mm series
Message-ID: <20051224104224.GA5789@stiffy.osknowledge.org>
References: <43ACEE14.7060507@feise.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43ACEE14.7060507@feise.com>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.15-rc6-marc-gd5ea4e26
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Joe Feise <jfeise@feise.com> [2005-12-23 22:43:32 -0800]:

> [Note: please cc me on answers since I'm not subscribed to the kernel list]
> 
> I am experiencing problems with mouse resyncing in the -mm series.
> This is a Logitech wheel mouse connected through a KVM.
> Symptom: whenever the mouse isn't moved for some seconds, it doesn't
> react to movement for a second, and then resyncs. Sometimes, the
> resyncing results in the mouse pointer jumping, which as far as I
> know is a protocol mismatch.
> While searching for reports of similar problems, I came across
> Frank Sorenson's post from Nov. 23 (http://lkml.org/lkml/2005/11/23/533).
> Like in his case, reverting
> input-attempt-to-re-synchronize-mouse-every-5-seconds.patch
> resulted in a kernel without this problem.
> 
> -Joe

Hi Joe,

read these ones:

http://lkml.org/lkml/2005/11/18/152
http://www.uwsg.iu.edu/hypermail/linux/kernel/0511.3/0019.html

Maybe they help you out.

I didn't get it working in the rc5 -mm tree so far. But non -mm work as good as
they always did.

Marc
