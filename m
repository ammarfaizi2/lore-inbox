Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271205AbRHTLut>; Mon, 20 Aug 2001 07:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271204AbRHTLuj>; Mon, 20 Aug 2001 07:50:39 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:53904 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP
	id <S271205AbRHTLuY>; Mon, 20 Aug 2001 07:50:24 -0400
From: Ian Stirling <root@mauve.demon.co.uk>
Message-Id: <200108201150.MAA08736@mauve.demon.co.uk>
Subject: Re: Encrypted Swap
To: linux-kernel@vger.kernel.org (l)
Date: Mon, 20 Aug 2001 12:50:11 +0100 (BST)
In-Reply-To: <Pine.LNX.3.95.1010819211427.28054B-100000@chaos.analogic.com> from "Richard B. Johnson" at Aug 19, 2001 09:27:28 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>
> Your idea of removing the RAM from the board and reading it
> from a RAM-reader may actually show some valid data. However,
> it is well thown that physical access to a machine or its
> components while the power is applied and the machine is
> running eliminates any possibility of security anyway.
> You just keep the machine on its UPS and carry it away.

Are there any current CPUs that can treat RAM as very fast swap, 
and be set up so that before writing a page of RAM from cache, it
gets encrypted (obviously not designed for this)
Essentially, the only data on the system that's in clear is initial boot
code, and on-chip cache.
Obviously, performance would suffer, going from Gb/s to Mb/s.
