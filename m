Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWIMLO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWIMLO2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 07:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWIMLO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 07:14:28 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:8414 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750794AbWIMLO1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 07:14:27 -0400
Date: Wed, 13 Sep 2006 13:13:31 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Martin Mares <mj@ucw.cz>
cc: David Wagner <daw-usenet@taverner.cs.berkeley.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: R: Linux kernel source archive vulnerable
In-Reply-To: <mj+md-20060913.103931.6418.albireo@ucw.cz>
Message-ID: <Pine.LNX.4.61.0609131312130.19571@yvahk01.tjqt.qr>
References: <20060907182304.GA10686@danisch.de> <20060913043319.GH541@1wt.eu>
 <ee8589$e70$1@taverner.cs.berkeley.edu> <1BB4231A-7D69-4A77-A050-1C633BDFA545@mac.com>
 <ee88af$fgo$1@taverner.cs.berkeley.edu> <mj+md-20060913.103931.6418.albireo@ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> In any case, regardless of whether this is by design or not, it is not
>> courteous to your users to distribute tar files where all the files have
>> permissions 0666.  That's not a user-friendly to do.
>
>I disagree.
>
>(1) Some systems use per-user groups and create all files group-writeable
>by default, i.e., they set the umask to 002. If you want to be user-friendly,
>you should respect this setting, so the permissions in the tar archives you
>distribute should be 666.
>
>(2) People extracting random archives as root with preserving permissions
>(and owners) are relying on *ALL* archive creators using what they suppose
>are the right permissions, which is at least simple-minded, if not completely
>silly. If you want to help such users, you should do so by helping them
>understand they do a wrong thing and not by hiding the problem in a single
>specific case.

And for those who -- for whatever reason -- extract kernelballs as root, 
should go use --no-same-permission.


Jan Engelhardt
-- 
