Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269915AbRHEFLz>; Sun, 5 Aug 2001 01:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269916AbRHEFLp>; Sun, 5 Aug 2001 01:11:45 -0400
Received: from weta.f00f.org ([203.167.249.89]:23696 "EHLO weta.f00f.org")
	by vger.kernel.org with ESMTP id <S269915AbRHEFLZ>;
	Sun, 5 Aug 2001 01:11:25 -0400
Date: Sun, 5 Aug 2001 17:12:02 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: /proc/<n>/maps getting _VERY_ long
Message-ID: <20010805171202.A20716@weta.f00f.org>
In-Reply-To: <20010805034312.A18996@weta.f00f.org> <Pine.LNX.4.33L.0108042316430.2526-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0108042316430.2526-100000@imladris.rielhome.conectiva>
User-Agent: Mutt/1.3.20i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 04, 2001 at 11:17:26PM -0300, Rik van Riel wrote:

    > cw:tty5@tapu(cw)$ wc -l /proc/1368/maps
    >    5287 /proc/1368/maps
    
    Ouch, what kind of application is this happening with ?

Mozilla.  Presumably some of the Gnome applications might be the same
as they use lots and lots of shared libraries (anyone out there Gnome
inflicted and can check?).

Why do we no longer merge? Is it too expensive?  If so, perhaps we
defer merging in some value is reached?

    IA64: a worthy successor to i860.

Interrupts aside it wasn't a bad little processor :)



  --cw

