Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310470AbSDMUU3>; Sat, 13 Apr 2002 16:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310517AbSDMUU2>; Sat, 13 Apr 2002 16:20:28 -0400
Received: from bnathan.remote.ics.uci.edu ([128.195.36.198]:32239 "HELO
	cx518206-b.irvn1.occa.home.com") by vger.kernel.org with SMTP
	id <S310470AbSDMUU2>; Sat, 13 Apr 2002 16:20:28 -0400
Subject: Re: Very trace tcp issue on 2.2.19
To: public@dgmo.org
Date: Sat, 13 Apr 2002 13:20:50 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m1sn5zq4n6.fsf@mo.optusnet.com.au> from "public@dgmo.org" at Apr 13, 2002 08:22:53 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20020413202050.6C12C897E0@cx518206-b.irvn1.occa.home.com>
From: barryn@pobox.com (Barry K. Nathan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've got an app (backup program) writing large
> quantities over data over a TCP connection from
> one 2.2.19 kernel to another.
> 
> My problem is that after a while, the connection simply
> hangs. The application on the local side is sleeping
> in read(), netstat on the local side show an empty
> receive Q.
> 
> Netstat on the remote site show a large send Q:
[snip]

There have been networking fixes since 2.2.19; you might want to try
2.2.21-rc3 (or if that's not possible, 2.2.20) and see if that improves
anything.

-Barry K. Nathan <barryn@pobox.com>
