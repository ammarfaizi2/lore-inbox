Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270373AbTG2DUw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 23:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270416AbTG2DUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 23:20:52 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:8873
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S270373AbTG2DUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 23:20:51 -0400
From: Con Kolivas <kernel@kolivas.org>
To: gaxt <gaxt@rogers.com>
Subject: Re: WINE + Galciv + Con Kolivar's 09 patch to  2.6.0-test1-mm2
Date: Tue, 29 Jul 2003 13:25:09 +1000
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <3F22F75D.8090607@rogers.com> <200307290739.04993.kernel@kolivas.org> <3F25DC33.8080908@rogers.com>
In-Reply-To: <3F25DC33.8080908@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307291325.09096.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jul 2003 12:30, gaxt wrote:
> Con Kolivas wrote:
> > File I/O ? Try booting with elevator=deadline
>
> Setting elevator=deadline results in wine+galciv loading without the
> horrible long pauses but there is still chugging and while the AVIs
> play, the rest of Gnome is unresponsive (ie can't switch windows by
> clicking etc) though I can switch to Alt-F1 virtual terminal. Still not
> as good as 260-test-2-vanilla

Well that is weird, but no doubt IO is playing some part here. Can you please 
try the preview O11 patch (incremental against 2.6.0-test2-mm1 but should 
patch against an O10 patched vanilla) in 

http://kernel.kolivas.org/2.5/experimental

While not specifically addressing this problem, it may help.

Con

