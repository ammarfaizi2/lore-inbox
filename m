Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281359AbRKMA7J>; Mon, 12 Nov 2001 19:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281355AbRKMA67>; Mon, 12 Nov 2001 19:58:59 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:55812 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281326AbRKMA6s>; Mon, 12 Nov 2001 19:58:48 -0500
Subject: Re: I'm sorry [it was: Nazi Kernels]
To: lobo@polbox.com
Date: Tue, 13 Nov 2001 01:05:54 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011113024806.A13176@chello062179017166.chello.pl> from "lobo@polbox.com" at Nov 13, 2001 02:48:06 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E163S1S-0007oa-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> "Note: modules without a GPL compatible license cannot use \
> GPLONLY_ symbols". It's Your decision, but in My opinion, its not
> the right way. I'm affraid, that this doesn't change the hardware
> manufacters opinions about the binary distributions of the drivers,
> so they copy or write this functions, and the only effect for end
> user will be more memory consumption (I know that memory is cheap
> today). I think in the future this may be the right way, but today
> it's to early for that step.

GPLONLY is used for symbols that are part of an object rather than core
interface ABI's. Its to help assist in reminding vendors not to accidentally
create derivative works that might be license violations. It doesnt actually
change the rules one iota

And I'd worry a lot more about binary only unmaintainable code than size
