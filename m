Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264397AbTCYX3I>; Tue, 25 Mar 2003 18:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264399AbTCYX3I>; Tue, 25 Mar 2003 18:29:08 -0500
Received: from rivmkt61.wintek.com ([206.230.0.61]:21998 "EHLO dust")
	by vger.kernel.org with ESMTP id <S264397AbTCYX3H>;
	Tue, 25 Mar 2003 18:29:07 -0500
Date: Tue, 25 Mar 2003 18:42:34 -0500 (EST)
From: Alex Goddard <agoddard@purdue.edu>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 502] New: Broken cursor when using neofb
In-Reply-To: <1352210000.1048622262@flay>
Message-ID: <Pine.LNX.4.53.0303251839270.4457@dust>
References: <1352210000.1048622262@flay>
X-GPG-PUBLIC_KEY: N/a
X-GPG-FINGERPRINT: BCBC 0868 DB78 22F3 A657 785D 6E3B 7ACB 584E B835
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Mar 2003, Martin J. Bligh wrote:

> http://bugme.osdl.org/show_bug.cgi?id=502
> 
>            Summary: Broken cursor when using neofb
>     Kernel Version: 2.5.66
>             Status: NEW
>           Severity: normal
>              Owner: jsimmons@infradead.org
>          Submitter: jochen@jochen.org
> 
> 
> Distribution: Debian sarge
> Hardware Environment: IBM Thinkpad 600
> 
> Problem Description:
> 
> I use neofb, the boot messages are:
> Mar 25 20:04:58 gswi1164 kernel: neofb: mapped io at c680d000
> Mar 25 20:04:58 gswi1164 kernel: Autodetected internal display
> Mar 25 20:04:58 gswi1164 kernel: Panel is a 1024x768 color TFT display
> Mar 25 20:04:58 gswi1164 kernel: neofb: mapped framebuffer at c6a0e000
> Mar 25 20:04:58 gswi1164 kernel: neofb v0.4.1: 2048kB VRAM, using 1024x768, 48.361kHz, 60Hz
> Mar 25 20:04:58 gswi1164 kernel: fb0: MagicGraph 128XD frame buffer device
> Mar 25 20:04:58 gswi1164 kernel: Console: switching to colour frame buffer device 128x48
> 
> On a vc the line cursor looks like
> ****** ** ********
> instead of
> ****************** (the normally continous line is broken).
> Emacs uses a block cursor that is broken similar, the block
> is broken by two vertical bars.

The VESA fbcon does exactly this as well.

I can grab my boot messages if they would help.

-- 
Alex Goddard
agoddard@purdue.edu
