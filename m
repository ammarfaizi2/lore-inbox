Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267961AbTAMR76>; Mon, 13 Jan 2003 12:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267972AbTAMR76>; Mon, 13 Jan 2003 12:59:58 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:5132 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S267961AbTAMR7o>;
	Mon, 13 Jan 2003 12:59:44 -0500
Date: Mon, 13 Jan 2003 19:08:17 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: dada1 <dada1@cosmosbay.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [RFC] Consolidate vmlinux.lds.S files
Message-ID: <20030113180817.GB1870@mars.ravnborg.org>
Mail-Followup-To: dada1 <dada1@cosmosbay.com>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
References: <20030112220741.GA15849@mars.ravnborg.org> <01fe01c2baed$5c123db0$6900a8c0@edumazet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01fe01c2baed$5c123db0$6900a8c0@edumazet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2003 at 11:19:58AM +0100, dada1 wrote:
> 
> > + TEXT_SECTION_CMD(0xC0000000 + 0x100000,, 0x9090, )
> 
> Could you change in arch/i386/vmlinux-lds.S the 0xC0000000 by PAGE_OFFSET
> (defined in include/asm-i386/page.h)
> 
> TEXT_SECTION_CMD(PAGE_OFFSET + 0x100000,, 0x9090, )

Good suggestion, I will do that.

	Sam
