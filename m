Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263113AbTJZL77 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 06:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263115AbTJZL77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 06:59:59 -0500
Received: from [217.73.128.98] ([217.73.128.98]:37760 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id S263113AbTJZL76 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 06:59:58 -0500
Date: Sun, 26 Oct 2003 14:59:43 +0200
Message-Id: <200310261259.h9QCxhWv004314@car.linuxhacker.ru>
From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: Blockbusting news, results end
To: ndiamond@wta.att.ne.jp, vitaly@namesys.com, linux-kernel@vger.kernel.org,
       reiser@namesys.com
References: <346101c39b9e$35932680$24ee4ca5@DIAMONDLX60> <3F9BA98B.20408@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> wrote:

HR> Badblocks support is in reiser4, and anyone is welcome to update the 
HR> patch for V3, or sponsor us to do it.  We are very low on cash, so we 

Actually that v3 patch does not do bad blocks remapping in case of
write failure, it only does remapping when you manually ask it.
And biggest part of badblocks support in reiser3 is in reiserfsck and tools
(and in not that bad shape, last time I looked).
As for remapping bad blocks on write failure, the only PC OS that was doing
this that comes to my mind is Novell Netware (I think they called it a "hotfix"
or something like that).

Bye,
    Oleg
