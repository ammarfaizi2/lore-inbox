Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750922AbWEHSV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbWEHSV1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 14:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWEHSV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 14:21:27 -0400
Received: from leitseite.net ([213.239.214.51]:3216 "EHLO mail.leitseite.net")
	by vger.kernel.org with ESMTP id S1750922AbWEHSV0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 14:21:26 -0400
Date: Mon, 8 May 2006 20:21:16 +0200 (CEST)
From: Nuri Jawad <lkml@jawad.org>
X-X-Sender: lkml@pc
To: linux-kernel@vger.kernel.org
Subject: Re: Re: Remove silly messages from input layer. 
Message-ID: <Pine.LNX.4.64.0605081950210.4170@pc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joseph Fannin wrote:
>Spamming my logs with these messages so often that my dmesg buffer
>soon contains nothing but and I have to use grep -v to read my syslog
>is not user-friendly, and I am hardly a novice.

I don't doubt that, but we're going in circles here. I never alleged this 
message was useful for everyone, but it IS useful for users with a working 
keyboard and specifically with mechanical switches (can be triggered by a 
loose cable or too slow turning of the dial, this a few times repeated can
cause the keyboard *port* to lock up, requiring a reboot).

If you have broken hardware that keeps triggering an error message that 
is valid and informative for a majority of users, use the source and 
comment it out. Nobody has a problem with that.
But don't try something that will leave us with no error messages left in 
the long run because somebody somewhere with broken hard- or software got 
spammed by them.

To the topic starter: calling such a message "silly" is pretty silly. And 
that from a distro maintainer..

Regards, Nuri
