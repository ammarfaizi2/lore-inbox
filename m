Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbVHATZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbVHATZt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 15:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbVHATZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 15:25:49 -0400
Received: from dsl3-63-249-67-69.cruzio.com ([63.249.67.69]:52654 "EHLO
	cichlid.com") by vger.kernel.org with ESMTP id S261162AbVHATZs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 15:25:48 -0400
Date: Mon, 1 Aug 2005 12:25:47 -0700
From: Andrew Burgess <aab@cichlid.com>
Message-Id: <200508011925.j71JPlci011555@cichlid.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12.3 Oops
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker said:
>> Seems to be triggered by mplayer but not right away (30 minutes sometimes), sometimes
>> no mplayer is necessary.
>> 
>> This is a busy machine. There is continuous usb soundcard (3 soundcards) and
>> usb ethernet activity (news server and alot of downloading) and video is being
>> read continuously from the bt878 card.
>> 
>> Any suggestions for workarounds are greatly appreciated. I'm going to try running
>> with swap off and see if that helps.

>You might want to enable slab debugging. Here's how,

OK thanks. I think I'll also switch to 2.6.14rc4 just in case it's something that's
already been fixed. Am compiling a slab debug 2.6.14rc4 now...

Bodo Eggert said:
>Let me guess: A VIA mainboard?

ABIT IC7, sorry I should have mentioned it.

It happens even if I never run mplayer. The video capturing is what is new,
previously the system was pretty stable.

