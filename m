Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262244AbTCMNfU>; Thu, 13 Mar 2003 08:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262364AbTCMNfU>; Thu, 13 Mar 2003 08:35:20 -0500
Received: from cygnus-ext.enyo.de ([212.9.189.162]:63246 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id <S262244AbTCMNfS>;
	Thu, 13 Mar 2003 08:35:18 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: NetFlow export
From: Florian Weimer <fw@deneb.enyo.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Thu, 13 Mar 2003 14:46:04 +0100
In-Reply-To: <20030313122932.GB29730@unthought.net> (Jakob Oestergaard's
 message of "Thu, 13 Mar 2003 13:29:33 +0100")
Message-ID: <87llzj8jmr.fsf@deneb.enyo.de>
User-Agent: Gnus/5.090016 (Oort Gnus v0.16) Emacs/21.2 (gnu/linux)
References: <87adfza5kb.fsf@deneb.enyo.de>
	<20030313114809.GA29730@unthought.net> <87znnz8oob.fsf@deneb.enyo.de>
	<20030313122932.GB29730@unthought.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakob Oestergaard <jakob@unthought.net> writes:

> You asked for netflow data export. Netramet can give you something
> similar to netflow (I never used netflow, but from what I hear, netramet
> is similar only more flexible).

I need the NetFlow data format, not something else.

> With 10 lines of Perl you could do full ASN-1   ;)

NetFlow is not based on ASN.1.  It's a completely different format (an
industry standard which is implemented by quite a few vendors).

> Point being; if what you want is flow information from a Linux router,
> excellent user space software (both "meter" and retrieval/filtering
> tools) already exist for that.

I fear the performance impact of copying all packet headers to user
space.

> If you want something else, then I have completely misread your mails.
> Please elaborate, in that case  :)

I'd like to see something which has virtually no impact on forwarding,
so that it's a no-brainer to enable it.  I doubt copying all the
packet headers to user space falls into this category.
