Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276643AbRJHGUf>; Mon, 8 Oct 2001 02:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276616AbRJHGUY>; Mon, 8 Oct 2001 02:20:24 -0400
Received: from dict.and.org ([63.113.167.10]:25779 "EHLO mail.and.org")
	by vger.kernel.org with ESMTP id <S276457AbRJHGUN>;
	Mon, 8 Oct 2001 02:20:13 -0400
To: Richard Henderson <rth@twiddle.net>
Cc: Andreas Schwab <schwab@suse.de>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.10-pre11 -- __builtin_expect
In-Reply-To: <20010918031813.57E1062ABC@oscar.casa.dyndns.org.suse.lists.linux.kernel>
	<E15jBLy-0008UF-00@the-village.bc.nu.suse.lists.linux.kernel>
	<9o6j9l$461$1@cesium.transmeta.com.suse.lists.linux.kernel>
	<oup4rq0bwww.fsf_-_@pigdrop.muc.suse.de>
	<jeelp4rbtf.fsf@sykes.suse.de>
	<20010918143827.A16003@gruyere.muc.suse.de>
	<nn3d59qzho.fsf@code.and.org> <jezo7gu78f.fsf@sykes.suse.de>
	<nnvgi4prod.fsf@code.and.org> <jeofnwsinb.fsf@sykes.suse.de>
	<20011004115204.A11463@twiddle.net>
From: James Antill <james@and.org>
Content-Type: text/plain; charset=US-ASCII
Date: 08 Oct 2001 02:17:33 -0400
In-Reply-To: <20011004115204.A11463@twiddle.net>
Message-ID: <nnvghqodtu.fsf@code.and.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Henderson <rth@twiddle.net> writes:

> On Thu, Sep 27, 2001 at 06:28:08PM +0200, Andreas Schwab wrote:
> > You're right, seems like __builtin_expect is really only defined for pure
> > boolean values.
> 
> I think the documentation mentions the current deficiency in that area.
> It is _supposed_ to be defined for all integral and pointer types, but
> that is hard with the current built-in infrastructure in the C front end.

 The documentation in the info files doesn't suggest that, in fact it
says...

    Since you are limited to integral expressions for EXP, you should
    use constructions such as

          if (__builtin_expect (ptr != NULL, 1))
            error ();

     when testing pointer or floating-point values.

-- 
# James Antill -- james@and.org
:0:
* ^From: .*james@and\.org
/dev/null
