Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263761AbUHYVee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263761AbUHYVee (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 17:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263962AbUHYVdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 17:33:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:8143 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268712AbUHYV1S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 17:27:18 -0400
Date: Wed, 25 Aug 2004 14:25:12 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: pmarques@grupopie.com, linux-kernel@vger.kernel.org, bcasavan@sgi.com
Subject: Re: [PATCH] kallsyms data size reduction / lookup speedup
Message-Id: <20040825142512.5535dc53.rddunlap@osdl.org>
In-Reply-To: <20040825205113.GA7258@mars.ravnborg.org>
References: <1093406686.412c0fde79d4f@webmail.grupopie.com>
	<20040825205113.GA7258@mars.ravnborg.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Aug 2004 22:51:13 +0200 Sam Ravnborg wrote:

| On Wed, Aug 25, 2004 at 05:04:46AM +0100, pmarques@grupopie.com wrote:
| > 
| > This patch is an improvement over my first kallsyms speedup patch posted about 2
| > weeks ago.
| 
| My origianl comment still hold.
| Decoupling the compression and decompression part is not good.
| Better keep them close to each other.
| 
| Why not put all symbols in an __init section, compress them during kernel boot
| and then the original section get discarded.
| 
| After a quick browse of the code.
| - Use spaces around '=' etc.

I just want to emphasize Sam's last comment.  Find and use that
'spacebar' thingy a lot more.  Make the code human-readable, not
just machine-readable.

--
~Randy
