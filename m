Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271211AbTG2CS4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 22:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271226AbTG2CS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 22:18:56 -0400
Received: from fep01-mail.bloor.is.net.cable.rogers.com ([66.185.86.71]:34702
	"EHLO fep01-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S271211AbTG2CSv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 22:18:51 -0400
Message-ID: <3F25DC33.8080908@rogers.com>
Date: Mon, 28 Jul 2003 22:30:11 -0400
From: gaxt <gaxt@rogers.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030708 Thunderbird/0.1a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: WINE + Galciv + Con Kolivar's 09 patch to  2.6.0-test1-mm2
References: <3F22F75D.8090607@rogers.com> <200307271205.59230.kernel@kolivas.org> <3F25985C.2090109@rogers.com> <200307290739.04993.kernel@kolivas.org>
In-Reply-To: <200307290739.04993.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep01-mail.bloor.is.net.cable.rogers.com from [65.49.219.239] using ID <dw2price@rogers.com> at Mon, 28 Jul 2003 22:18:11 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Tue, 29 Jul 2003 07:40, gaxt wrote:
> 
>>260-test2-vanilla works fine with a little stutter playing the avis
>>260-test2-O10 causes horrible stutter and loss of input to system
>>260-test2-mm1 causes horrible stutter and loss of input to system
>>
>>NOTE: Instead of re-setting, by switching consoles by pressing Alt F7
>>then Alt-F1 back and forth (ie from X to virtual console) it seems I
>>could prod wine+galciv into edging forward, stalling, edging forward
>>etc. through the opening AVIs. ie. I would hear the sounds of the movie
>>advance each time  I switched into Alt-F1.
>>
>>Once into the turn-based game itself (after opening animations) ability
>>to input was restored again and the game can be played and windows moved
>>around etc.
>>
>>So it seems the playing of the little movies is what really locks up the
>>whole system using the O10/mm1 scheduling???
> 
> 
> File I/O ? Try booting with elevator=deadline
> 
> Con

Setting elevator=deadline results in wine+galciv loading without the 
horrible long pauses but there is still chugging and while the AVIs 
play, the rest of Gnome is unresponsive (ie can't switch windows by 
clicking etc) though I can switch to Alt-F1 virtual terminal. Still not 
as good as 260-test-2-vanilla

