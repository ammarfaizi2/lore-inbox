Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261558AbVAQX2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbVAQX2p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 18:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVAQXZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 18:25:31 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:51350
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S262970AbVAQWS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 17:18:29 -0500
Subject: Re: [RFC] Instrumentation (was Re: 2.6.11-rc1-mm1)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Karim Yaghmour <karim@opersys.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, Tim Bird <tim.bird@am.sony.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>
In-Reply-To: <41EC2157.1070504@opersys.com>
References: <20050114002352.5a038710.akpm@osdl.org>
	 <1105742791.13265.3.camel@tglx.tec.linutronix.de>
	 <41E8543A.8050304@am.sony.com>
	 <1105794499.13265.247.camel@tglx.tec.linutronix.de>
	 <41E9CCEF.50401@opersys.com> <Pine.LNX.4.61.0501160352130.6118@scrub.home>
	 <41E9EC5A.7070502@opersys.com>
	 <1105919017.13265.275.camel@tglx.tec.linutronix.de>
	 <41EB1AEC.3000106@opersys.com>
	 <1105957604.13265.388.camel@tglx.tec.linutronix.de>
	 <41EC2157.1070504@opersys.com>
Content-Type: text/plain
Date: Mon, 17 Jan 2005 23:18:27 +0100
Message-Id: <1106000307.13265.462.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-17 at 15:34 -0500, Karim Yaghmour wrote:
> Thomas Gleixner wrote:
> > Thats the point. Adding another hardwired implementation does not give
> > us a possibility to solve the hardwired problem of the already available
> > stuff.
> 
> Well then, like I said before, you know what you need to do:
> http://www-124.ibm.com/developerworks/oss/linux/projects/kernelhooks/

Oh, I guess my English must be really bad.

I was talking about seperation of layers, so why do I need
kernelhooks ? 

The seperation of layers makes it possible to actually reuse
functionality and gives the possibility that existing hardwired stuff
can be cleaned up to use the new functionality too. 

If we add another hardwired implementation then we do not have said
benefits.

tglx



