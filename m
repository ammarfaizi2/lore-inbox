Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269018AbUHMHn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269018AbUHMHn3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 03:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269019AbUHMHn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 03:43:28 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:17025 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S269018AbUHMHn1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 03:43:27 -0400
Date: Fri, 13 Aug 2004 09:44:57 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jakub Vana <gugux@centrum.cz>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: x86 - Realmode BIOS and Code calling module
Message-ID: <20040813074457.GA503@ucw.cz>
References: <20040812133854Z2097966-29039+40063@mail.centrum.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040812133854Z2097966-29039+40063@mail.centrum.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2004 at 03:38:45PM +0200, Jakub Vana wrote:

> > Why is this better than LRMI in user mode.
> 
> I was now looking on LRMI. It must be a nice code, but It is still
> only V86 emulation. I have listen that some BIOSes use something
> called Unreal mode, that is realmode with segment registers used like
> in protected mode. There is only one way, how to set this segregs -
> switch to prot. mode, but if the BIOS try to switch when is running in
> V86 CPU generates #GP (Global Protection fault). Not if it is running
> in real Real Mode.

Well, if it's running an emulated CPU (x86emu), there are no problems
with that. Even the unreal mode could be emulated, although I have yet
to see a BIOS which uses that to handle an INT call.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
