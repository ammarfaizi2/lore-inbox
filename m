Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265802AbUAPT55 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 14:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265815AbUAPT55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 14:57:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:61104 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265802AbUAPT4S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 14:56:18 -0500
Date: Fri, 16 Jan 2004 11:52:37 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "raymond jennings" <highwind747@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [IDEA] - run-length compaction of block numbers
Message-Id: <20040116115237.08b65335.rddunlap@osdl.org>
In-Reply-To: <BAY1-F117hxeH6PC8MS00006f92@hotmail.com>
References: <BAY1-F117hxeH6PC8MS00006f92@hotmail.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jan 2004 11:38:59 -0800 "raymond jennings" <highwind747@hotmail.com> wrote:

| Is there any value in creating a new filesystem that encodes long contiguous 
| blocks as a single block run instead of multiple block numbers?  A long file 
| may use only a few block runs instead of many block numbers if there is 
| little fragmentation (usually the case).  Also dynamic allocation of 
| inodes...etc.  The details are long; anyone interested can e-mail me 
| privately.

You mean line ext3fs + extents, or like JFS or XFS, which use extents?

--
~Randy
Everything is relative.
