Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272832AbTHKQqV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 12:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272837AbTHKQqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 12:46:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:33447 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272832AbTHKQqP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 12:46:15 -0400
Date: Mon, 11 Aug 2003 09:43:04 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: bzzz@tmi.comex.ru, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: [RFC] file extents for EXT3
Message-Id: <20030811094304.10369817.rddunlap@osdl.org>
In-Reply-To: <3F3791C8.4090903@pobox.com>
References: <m3ptjcabey.fsf@bzzz.home.net>
	<3F3791C8.4090903@pobox.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Aug 2003 08:53:28 -0400 Jeff Garzik <jgarzik@pobox.com> wrote:

| Alex Tomas wrote:
| > hello all!
| > 
| > there are several problems with old good method ext2/ext3
| > use to store map of block for an inode. for example, ext3's
| > truncate is quite slow. I think extents could solve this
| > and some other troubles. so ...
| > 
| > 
| > in fact, design is taken from htree modern ext2/ext3 uses. in constrast with
| > htree, it isn't backward-compatible.
| 
| Neat.  I really like extents, and think this is the best long-term 
| approach.  Apparently the ext3 maintainers do, too, because tytso/sct's 
| "ext roadmap" paper publishing a while ago describes extents, too.  (I 
| wish I had a URL for that)

like this?  http://www.usenix.org/publications/library/proceedings/usenix02/tech/freenix/tso.html


--
~Randy				For Linux-2.6, see:
http://www.kernel.org/pub/linux/kernel/people/davej/misc/post-halloween-2.5.txt
