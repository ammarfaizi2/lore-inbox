Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264087AbTKSOdl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 09:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264088AbTKSOdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 09:33:41 -0500
Received: from eik.ii.uib.no ([129.177.16.3]:54167 "EHLO mail.ii.uib.no")
	by vger.kernel.org with ESMTP id S264087AbTKSOdk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 09:33:40 -0500
Subject: Re: 2.6.0-test9-mm4 - kernel BUG at arch/i386/mm/fault.c:357!
From: "Ronny V. Vindenes" <s864@ii.uib.no>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20031119142230.GX22764@holomorphy.com>
References: <1069246427.5257.12.camel@localhost.localdomain>
	 <20031119130220.GT22764@holomorphy.com>
	 <1069248455.5257.26.camel@localhost.localdomain>
	 <20031119140222.GV22764@holomorphy.com>
	 <1069251503.3390.1.camel@localhost.localdomain>
	 <20031119142230.GX22764@holomorphy.com>
Content-Type: text/plain
Message-Id: <1069252411.5007.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 19 Nov 2003 15:33:31 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.9 (+)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1AMTOh-0007Au-00*uItc3enZ6Dc*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-11-19 at 15:22, William Lee Irwin III wrote:
> On Wed, Nov 19, 2003 at 03:18:23PM +0100, Ronny V. Vindenes wrote:
> > bad nopage snd_pcm_mmap_data_nopage+0x0/0xc0 [snd_pcm]
> > handle_mm_fault() returned bad status
> 
> 
> diff -prauN mm4-2.6.0-test9-1/sound/core/pcm_native.c mm4-2.6.0-test9-dbg-1/sound/core/pcm_native.c

That fixed it, thanks!

-- 
Ronny V. Vindenes <s864@ii.uib.no>

