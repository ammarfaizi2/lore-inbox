Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267688AbTA1TMP>; Tue, 28 Jan 2003 14:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267690AbTA1TMP>; Tue, 28 Jan 2003 14:12:15 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:45062 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S267688AbTA1TMO>;
	Tue, 28 Jan 2003 14:12:14 -0500
Date: Tue, 28 Jan 2003 20:20:46 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] new modversions implementation
Message-ID: <20030128192046.GA1173@mars.ravnborg.org>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <20030125215637.GA3571@mars.ravnborg.org> <20030128091625.4790C2C2AC@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030128091625.4790C2C2AC@lists.samba.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2003 at 06:06:17PM +1100, Rusty Russell wrote:
> > 
> > The member "num_syms" says something about number of symbols,
> > but is contains the syms_size. Misleading name.
> 
> I think you've missed the declaration:
> 
> extern const struct kernel_symbol __start___ksymtab[];

Yep, for a second I forgot about pointer aritmetics and starting
considering (void *).
Kai already pointed out this to me :-(

	Sam
