Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271798AbRIQQWl>; Mon, 17 Sep 2001 12:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271818AbRIQQWb>; Mon, 17 Sep 2001 12:22:31 -0400
Received: from ns.suse.de ([213.95.15.193]:23571 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S271798AbRIQQWT>;
	Mon, 17 Sep 2001 12:22:19 -0400
Date: Mon, 17 Sep 2001 18:22:33 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: Jean-Marc Saffroy <saffroy@ri.silicomp.fr>
Cc: <linux-kernel@vger.kernel.org>, <linux-smp@vger.kernel.org>
Subject: Re: [Q] Implementation of spin_lock on i386: why "rep;nop" ?
In-Reply-To: <Pine.LNX.4.31.0109171725140.26090-100000@sisley.ri.silicomp.fr>
Message-ID: <Pine.LNX.4.30.0109171821340.27689-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Sep 2001, Jean-Marc Saffroy wrote:

> What is the intent behind this "rep;nop" ? Does it really rely on an
> undocumented behaviour ?

Its used to stop Pentium 4's from cooking themselves.
See the P4 manuals for more info.

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

