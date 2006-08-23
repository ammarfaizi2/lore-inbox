Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965028AbWHWQVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965028AbWHWQVY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 12:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965029AbWHWQVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 12:21:24 -0400
Received: from webmailv3.ispgateway.de ([80.67.16.113]:26015 "EHLO
	webmailv3.ispgateway.de") by vger.kernel.org with ESMTP
	id S965028AbWHWQVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 12:21:23 -0400
Message-ID: <1156350066.44ec80722128b@domainfactory-webmail.de>
Date: Wed, 23 Aug 2006 18:21:06 +0200
From: Clemens Ladisch <clemens@ladisch.de>
To: Nathan Becker <nathanbecker@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: kernel panic when sending MIDI sequencer events
References: <2151339d0607251301i716f6a01i17b07de5e7905ffc@mail.gmail.com>  <s5h3bcpsar9.wl%tiwai@suse.de> <s5hzmexqvzv.wl%tiwai@suse.de>  <2151339d0607251739s15a4b52exf1aaf4afac8559f8@mail.gmail.com>  <s5hbqrbotey.wl%tiwai@suse.de> <2151339d0608142036o54e94369r8168fa4854e2ccc7@mail.gmail.com>
In-Reply-To: <2151339d0608142036o54e94369r8168fa4854e2ccc7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.8
X-Originating-IP: 213.238.46.206
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Becker wrote:
> I am getting a kernel panic whenever I try to play MIDI.  It
> appears this is somehow related to the RTC.

Try disabling CONFIG_SND_SEQ_RTCTIMER_DEFAULT.


HTH
Clemens

