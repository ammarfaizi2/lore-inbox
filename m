Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964961AbVI0O42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961AbVI0O42 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 10:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbVI0O42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 10:56:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1229 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964961AbVI0O41 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 10:56:27 -0400
Date: Tue, 27 Sep 2005 07:55:52 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
cc: linux-kernel@vger.kernel.org, Michael Kerrisk <michael.kerrisk@gmx.net>,
       Michal Wronski <michal.wronski@gmail.com>
Subject: Re: [PATCH] umask in POSIX message queues
In-Reply-To: <Pine.GSO.4.58.0509271246570.2336@Juliusz>
Message-ID: <Pine.LNX.4.58.0509270754290.3308@g5.osdl.org>
References: <Pine.GSO.4.58.0509261218080.5216@Juliusz>
 <Pine.LNX.4.58.0509261827150.3308@g5.osdl.org> <Pine.GSO.4.58.0509271246570.2336@Juliusz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 Sep 2005, Krzysztof Benedyczak wrote:
> 
> After rereading it I think that the better place for the line setting
> umask is do_create() function as it will be on the same level as
> open_namei(). I hope this change will clarify things.
> 
> If this make sense I'll send a patch.

Yes, that makes more sense.

Please do send a tested patch,

		Linus
