Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbUCaVt4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 16:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbUCaVtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 16:49:06 -0500
Received: from fw.osdl.org ([65.172.181.6]:22988 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262632AbUCaVp1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 16:45:27 -0500
Date: Wed, 31 Mar 2004 13:42:15 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Casey Allen Shobe" <cshobe@osss.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mem=options changed in 2.6.x?
Message-Id: <20040331134215.21350e55.rddunlap@osdl.org>
In-Reply-To: <44574.64.25.5.177.1080768515.squirrel@webmail.thebrittinggroup.com>
References: <44574.64.25.5.177.1080768515.squirrel@webmail.thebrittinggroup.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2004 16:28:35 -0500 (EST) Casey Allen Shobe wrote:

| I have a Compaq Proliant 5000 with 320Mb RAM.
| 
| If I boot up either linux 2.4.22 or 2.6.4, it only identifies 12Mb of memory.
| 
| With 2.4.22, the kernel parameters "mem=exactmap mem=640k@0M mem=319M@1M"
| worked to make the kernel identify all of the memory.
| 
| I have tried the same with linux 2.6.4, but with the above flags the
| kernel will not boot.  With "mem=320M", the system boots, but it still
| thinks it has only 12Mb RAM.
| 
| Something I'm missing or did this change between releases?

See file: Documentation/kernel-parameters.txt

Basically, you need to change "mem=" to "memmap=" in all 3 places
above.

--
~Randy
"You can't do anything without having to do something else first."
-- Belefant's Law
