Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262752AbVAQJyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262752AbVAQJyS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 04:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262754AbVAQJyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 04:54:18 -0500
Received: from canuck.infradead.org ([205.233.218.70]:19469 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262752AbVAQJyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 04:54:14 -0500
Subject: Re: [discuss] booting a kernel compiled with -mregparm=0
From: Arjan van de Ven <arjan@infradead.org>
To: Tigran Aivazian <tigran@veritas.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Jan Hubicka <jh@suse.cz>,
       Jack F Vogel <jfv@bluesong.net>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0501170909040.4593@ezer.homenet>
References: <Pine.LNX.4.61.0501141623530.3526@ezer.homenet>
	 <20050114205651.GE17263@kam.mff.cuni.cz>
	 <Pine.LNX.4.61.0501141613500.6747@chaos.analogic.com>
	 <cs9v6f$3tj$1@terminus.zytor.com>
	 <Pine.LNX.4.61.0501170909040.4593@ezer.homenet>
Content-Type: text/plain
Date: Mon, 17 Jan 2005 10:53:27 +0100
Message-Id: <1105955608.6304.60.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-17 at 09:30 +0000, Tigran Aivazian wrote:
> I cc'd Linus as I cannot believe he agreed with allowing such an 
> optimization to be a default and standard thing accepted by the Linux 
> kernel. (But I may be wrong, especially since Linus isn't particularly 
> fond of kdb anyway :)

I don't see a problem, have you ever seen ia64??
> Actually, having cc'd Linus made me think very _carefully_ about what I 
> say and I went and checked how the userspace does it, as I couldn't 
> believe that such fine piece of software as gdb would be broken as well. 
> And to my surprize I discovered that gdb (when a program is compiled with 
> -g) works fine! I.e. it shows the function arguments correctly. And 


so why don't you use kgdb instead of kdb ?


