Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263199AbUDEVO0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 17:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262963AbUDEVOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 17:14:17 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:50311 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263214AbUDEVLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 17:11:54 -0400
Message-ID: <4071CB80.70405@nortelnetworks.com>
Date: Mon, 05 Apr 2004 17:11:28 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Jamie Lokier <jamie@shareable.org>, bero@arklinux.org,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Catching SIGSEGV with signal() in 2.6
References: <Pine.LNX.4.58.0404050824310.13367@build.arklinux.oregonstate.edu> <20040405181707.GA21245@mail.shareable.org> <4071B093.9030601@nortelnetworks.com> <20040405204028.GA21649@mail.shareable.org> <Pine.LNX.4.53.0404051644440.2948@chaos>
In-Reply-To: <Pine.LNX.4.53.0404051644440.2948@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:

 > Are you using a longjump to get out of the signal handler?
 > You may find that you can trap SIGSEGV, but you can't exit
 > from it because it will return to the instruction that
 > caused the trap!!!

That's the same as in 2.4 though.  The original poster was talking about 
behaviour changes in 2.6.

Chris
