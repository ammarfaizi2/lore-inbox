Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262451AbVAJUHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbVAJUHX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 15:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262471AbVAJTrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 14:47:25 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:8909 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262451AbVAJTcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 14:32:54 -0500
Subject: Re: uselib()  & 2.6.X?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41E23E26.50403@bio.ifi.lmu.de>
References: <Pine.LNX.4.58LT.0501071648160.30645@oceanic.wsisiz.edu.pl>
	 <20050107170712.GK29176@logos.cnet>
	 <1105136446.7628.11.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0501071609540.2386@ppc970.osdl.org>
	 <20050107221255.GA8749@logos.cnet>
	 <Pine.LNX.4.58.0501081042040.2386@ppc970.osdl.org>
	 <20050108182841.GD2701@logos.cnet>
	 <Pine.LNX.4.58.0501081734400.2339@ppc970.osdl.org>
	 <20050109110630.GA9144@logos.cnet>  <41E23E26.50403@bio.ifi.lmu.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105380726.12004.79.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 10 Jan 2005 18:28:22 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-01-10 at 08:34, Frank Steiner wrote:
> Hi,
> 
> sorry, if this is a stupid question, but I now got lost in your discussion:
> 
> Is Linus patch at http://linux.bkbits.net:8080/linux-2.6/cset@1.2247.2.4
> enough to close the security hole, or do we need more (or wait a little
> longer)?

If you want a patch right now grab the -ac patches (they also fix a pile
of other less holes found including the grsecurity ones). The -ac
version of the fix should be complete but it won't be the final one in
the master tree (I get to nail holes shut Linus has to do the right
engineering for the long term 8))

