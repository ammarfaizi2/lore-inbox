Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbUCHVvP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 16:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbUCHVvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 16:51:15 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:18598 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S261262AbUCHVvL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 16:51:11 -0500
Message-ID: <404CEABA.4040701@matchmail.com>
Date: Mon, 08 Mar 2004 13:50:50 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040304)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Danny ter Haar <dth@ncc1701.cistron.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: server migration
References: <20040305181322.GA32114@the-penguin.otak.com> <c2agg7$9hf$1@news.cistron.nl>
In-Reply-To: <c2agg7$9hf$1@news.cistron.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Danny ter Haar wrote:
> Lawrence Walton  <lawrence@the-penguin.otak.com> wrote:
> 
>>I'd like to take another shot at it with 2.6.3,
> 
> 
> Don't!
> 
> <personal experience, ymmv!>
> Problems after sync, difficulties in the blocklayer/queuing/plugging.
> Our newsgateway has gone back to 2.6.0-test11 since that's the
> only one that seems to survive "hard-work".
> 
> 2.6.4-rc1(-mm1) crashed hard on me, doing single-user stuff.
> _i_ would wait a while if i were in your position.

I have everything except for my GW/Firewall running 2.6.3 + two NFS 
patches and everything is working great.

Maybe you should find out which driver is giving you trouble, and help 
debug that.

Did you enable the NMI watchdog?
What about sysrq, did that still respond during your "hang"?

Mike
