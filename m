Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270929AbTG1Vet (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 17:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271047AbTG1Vet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 17:34:49 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:24742
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S270929AbTG1Ves (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 17:34:48 -0400
From: Con Kolivas <kernel@kolivas.org>
To: gaxt <gaxt@rogers.com>
Subject: Re: WINE + Galciv + Con Kolivar's 09 patch to  2.6.0-test1-mm2
Date: Tue, 29 Jul 2003 07:39:04 +1000
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <3F22F75D.8090607@rogers.com> <200307271205.59230.kernel@kolivas.org> <3F25985C.2090109@rogers.com>
In-Reply-To: <3F25985C.2090109@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307290739.04993.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jul 2003 07:40, gaxt wrote:
> 260-test2-vanilla works fine with a little stutter playing the avis
> 260-test2-O10 causes horrible stutter and loss of input to system
> 260-test2-mm1 causes horrible stutter and loss of input to system
>
> NOTE: Instead of re-setting, by switching consoles by pressing Alt F7
> then Alt-F1 back and forth (ie from X to virtual console) it seems I
> could prod wine+galciv into edging forward, stalling, edging forward
> etc. through the opening AVIs. ie. I would hear the sounds of the movie
> advance each time  I switched into Alt-F1.
>
> Once into the turn-based game itself (after opening animations) ability
> to input was restored again and the game can be played and windows moved
> around etc.
>
> So it seems the playing of the little movies is what really locks up the
> whole system using the O10/mm1 scheduling???

File I/O ? Try booting with elevator=deadline

Con

