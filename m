Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317443AbSGTRAV>; Sat, 20 Jul 2002 13:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317446AbSGTRAV>; Sat, 20 Jul 2002 13:00:21 -0400
Received: from holomorphy.com ([66.224.33.161]:24980 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317443AbSGTRAU>;
	Sat, 20 Jul 2002 13:00:20 -0400
Date: Sat, 20 Jul 2002 10:03:13 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jari Ruusu <jari.ruusu@pp.inet.fi>
Cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@zip.com.au>,
       Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] loop.c oopses
Message-ID: <20020720170313.GE1096@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jari Ruusu <jari.ruusu@pp.inet.fi>, Jens Axboe <axboe@suse.de>,
	Andrew Morton <akpm@zip.com.au>,
	Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
References: <20020716163636.GW811@suse.de> <Pine.LNX.4.44L.0207161349100.3009-100000@duckman.distro.conectiva> <20020716170921.GX811@suse.de> <3D34773C.F61E7C0F@pp.inet.fi> <20020717054006.GZ811@suse.de> <3D358DD8.D39F06FF@pp.inet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D358DD8.D39F06FF@pp.inet.fi>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> Both 2.4 and 2.5 have same two bugs:
> 1)  lo->lo_pending never decremented in remap case
> 2)  remapping _never_ enabled (and this caused it to appear to work)

Jens Axboe wrote:
>> That said, please do split up the patches as Andrew/wli suggested. For
>> the 2.5 one I'd be inclined to just take it as-is, but the 2.4 patch
>> definitely needs to be split.

On Wed, Jul 17, 2002 at 06:31:36PM +0300, Jari Ruusu wrote:
> OK. Since 2.5.25 patch still applies to 2.5.26 with one 3-line offset, I
> won't send new one but comment the patch.

Isn't it more usual to send the individual bugfixes/whatever as entirely
separate patches? (I admit, this did explain quite a bit, though.)


Cheers,
Bill
