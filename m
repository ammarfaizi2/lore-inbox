Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131479AbRDSRE5>; Thu, 19 Apr 2001 13:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131477AbRDSREp>; Thu, 19 Apr 2001 13:04:45 -0400
Received: from rubicon.hasler.ascom.ch ([139.79.129.1]:31941 "EHLO
	rubicon.hasler.ascom.ch") by vger.kernel.org with ESMTP
	id <S131479AbRDSREc>; Thu, 19 Apr 2001 13:04:32 -0400
Date: Thu, 19 Apr 2001 19:04:26 +0200
From: Martin Buck <martin.buck@ascom.ch>
To: linux-kernel@vger.kernel.org
Subject: Re: Strange Oops in free_wait()/do_select()
Message-ID: <20010419190426.A26826@tux.ma.tech.ascom.ch>
In-Reply-To: <20010419152533.A22922@tux.ma.tech.ascom.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <20010419152533.A22922@tux.ma.tech.ascom.ch>; from buck on Thu, Apr 19, 2001 at 03:25:33PM +0200
X-Filter-Version: 1.2 (rubicon)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2001 at 03:25:33PM +0200, Martin Buck wrote:
> I'm getting strange Oopses with 2.2.17 on an AMD Athlon 1.2 GHz machine.
> [...]

BTW, I didn't mention it explicitly, but this kernel is *not*
Athlon-optimized (since I used it for several months on a P II and IIRC,
2.2.17 didn't offer Athlon-optimizaations anyway). It was compiled with gcc
2.95.2.

The motherboard is an Asus A7V133 with the KT133A chipset which probably
has the UDMA bug, but this shouldn't affect me since I'm only using SCSI on
the Athlon machine.

Martin
