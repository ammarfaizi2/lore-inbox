Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312524AbSDXS5a>; Wed, 24 Apr 2002 14:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312526AbSDXS53>; Wed, 24 Apr 2002 14:57:29 -0400
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:52491 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S312524AbSDXS52>; Wed, 24 Apr 2002 14:57:28 -0400
Date: Wed, 24 Apr 2002 20:56:22 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Kasper Dupont <kasperd@daimi.au.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.5.9 remove warnings
Message-ID: <20020424205622.J696@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <10704.1019533171@kao2.melbourne.sgi.com> <3CC5A8AF.432380E3@zip.com.au> <3CC5CD38.DC57DFA3@daimi.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2002 at 11:08:08PM +0200, Kasper Dupont wrote:
> Wouldn't "!!(x)" make more sense here than "(x) != 0"?
> (I don't like comparing pointers with integers.)

No, == 0 means, that the pointer is invalid, so != 0 means, the
pointer is valid. You can find this in the C99-Standard at least.

So, this is perfectly normal ;-)

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
