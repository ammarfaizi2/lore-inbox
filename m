Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262883AbSJaSIj>; Thu, 31 Oct 2002 13:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262859AbSJaSHb>; Thu, 31 Oct 2002 13:07:31 -0500
Received: from tapu.f00f.org ([66.60.186.129]:39910 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S262779AbSJaSG0>;
	Thu, 31 Oct 2002 13:06:26 -0500
Date: Thu, 31 Oct 2002 10:12:52 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Dax Kelson <dax@gurulabs.com>, Rik van Riel <riel@conectiva.com.br>,
       Linus Torvalds <torvalds@transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: What's left over.
Message-ID: <20021031181252.GB24027@tapu.f00f.org>
References: <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com> <Pine.LNX.4.44L.0210310105160.1697-100000@imladris.surriel.com> <20021031062249.GB18007@tapu.f00f.org> <1036046904.1521.74.camel@mentor> <20021031065629.GA19030@tapu.f00f.org> <3DC13EAD.9020408@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DC13EAD.9020408@pobox.com>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 09:31:09AM -0500, Jeff Garzik wrote:

> What's wrong with our current 2.5.45 crypto api?

It's synchronous and assume everything is synchronous.  Lots of
hardware (most) doesn't work that way.


  --cw

