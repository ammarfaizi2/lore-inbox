Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135577AbRDTAlc>; Thu, 19 Apr 2001 20:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135768AbRDTAlX>; Thu, 19 Apr 2001 20:41:23 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:35515 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135577AbRDTAlK>;
	Thu, 19 Apr 2001 20:41:10 -0400
Date: Thu, 19 Apr 2001 20:41:07 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Matthew Jacob <mjacob@feral.com>
cc: Andi Kleen <ak@suse.de>, "Brian J. Watson" <Brian.J.Watson@compaq.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: active after unmount?
In-Reply-To: <Pine.BSF.4.21.0104191517070.81926-100000@beppo.feral.com>
Message-ID: <Pine.GSO.4.21.0104192039430.19860-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Apr 2001, Matthew Jacob wrote:

> 
> 'kay, great, thanks.. I'll put it in and see if things show up again

Guys, it's a known bug, fixed in 2.4.4-pre3. See the change to fs/super.c
between 2.4.4-pre2 and 2.4.4-pre3 - it's quite small.

