Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135217AbREFIlK>; Sun, 6 May 2001 04:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135223AbREFIlA>; Sun, 6 May 2001 04:41:00 -0400
Received: from pc-62-30-75-17-az.blueyonder.co.uk ([62.30.75.17]:33548 "EHLO
	askone.octopus-technologies.co.uk") by vger.kernel.org with ESMTP
	id <S135217AbREFIkp>; Sun, 6 May 2001 04:40:45 -0400
Date: Sun, 6 May 2001 09:43:12 +0100 (BST)
From: Stephen Beynon <stephen@askone.demon.co.uk>
To: Aaron Lehmann <aaronl@vitelus.com>
cc: Peter Rival <frival@zk3.dec.com>, Anton Blanchard <anton@samba.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CPU hot swap for 2.4.3 + s390 support
In-Reply-To: <20010506010319.A10586@vitelus.com>
Message-ID: <Pine.LNX.4.21.0105060940170.3103-100000@askone.octopus-technologies.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 6 May 2001, Aaron Lehmann wrote:

> On Sat, May 05, 2001 at 10:43:27AM -0400, Peter Rival wrote:
> > Has anyone looked into memory hot swap/hot add support?
> 
> How do you hotswap RAM? What happens to the data that was on the
> removed memory module?

Dont know about the s390 - but on some hardware you get notification when
someone presses the hotswap request button.  You would then be requiried
to move all the data on the memory elsewhere.  Then you tell the hardware
it is ok to hotswap.  On many systems this will make the little LED light
up to say the hotswap is safe :)

Stephen

