Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265250AbSJaVFv>; Thu, 31 Oct 2002 16:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265354AbSJaVFr>; Thu, 31 Oct 2002 16:05:47 -0500
Received: from smtp2.mail.be.easynet.net ([212.100.160.76]:19876 "EHLO
	koshin.mail.be.easynet.net") by vger.kernel.org with ESMTP
	id <S265250AbSJaVFM>; Thu, 31 Oct 2002 16:05:12 -0500
Message-ID: <3DC19CA2.5040300@easynet.be>
Date: Thu, 31 Oct 2002 22:12:02 +0100
From: Luc Van Oostenryck <luc.vanoostenryck@easynet.be>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: CONFIG_TINY
References: <20021030233605.A32411@jaquet.dk> <Pine.NEB.4.44.0210310145300.20835-100000@mimas.fachschaften.tu-muenchen.de> <20021031011002.GB28191@opus.bloom.county> <20021031053310.GB4780@mark.mielke.cc> <20021031143301.GC28191@opus.bloom.county> <20021031165113.GB8565@mark.mielke.cc>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Mielke wrote:
 > On Thu, Oct 31, 2002 at 07:33:01AM -0700, Tom Rini wrote:
 >
 >>>If gcc regularly generates larger code with -Os the answer is to talk to
 >>>the gcc people, not to avoid using -Os...
 >>
 >>It's not that it does regularly, it's that it can, and if it does, it's
 >>not really a gcc bug from what I recall.  So I don't think CONFIG_TINY
 >>should prefer -Os over -O2 but instead we should just ask the user what
 >>level of optimization they want.  Remember, one of the real important
 >>parts of embedded systems is flexibility.
 >
 >
 > Not to stretch this point too long, but turning off inlined functions 'can'
 > make code bigger too. It usually doesn't.
 >

GCC's -finline-limit=n should help to control this.

--
Luc Van Oostenryck

Yes, madam, I am drunk.
But in the morning I will be sober and you will still be ugly.
	-- Winston Churchill




