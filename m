Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264515AbTEJVGk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 17:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264516AbTEJVGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 17:06:40 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:16256 "EHLO
	lapdancer.baythorne.internal") by vger.kernel.org with ESMTP
	id S264515AbTEJVGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 17:06:38 -0400
Subject: Re: [2.5.69] Does ISDN work at all?
From: David Woodhouse <dwmw2@infradead.org>
To: Kmt Sundqvist <rabbit80@mbnet.fi>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1263.194.100.163.20.1052593367.squirrel@webmail.mbnet.fi>
References: <1263.194.100.163.20.1052593367.squirrel@webmail.mbnet.fi>
Content-Type: text/plain
Organization: 
Message-Id: <1052601552.1881.17.camel@lapdancer.baythorne.internal>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5.dwmw2) 
Date: Sat, 10 May 2003 22:19:13 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-05-10 at 20:02, Kmt Sundqvist wrote:
> Hello
> 
> I've been unable to spot any information whether I should assume that ISDN
> just doesn't work yet in 2.5.x, or whether I should keep on trying to make
> it work.  All hints are appreciated.
> 
> I only get lots of unknown symbols when trying to modprobe hisax.
> 
> I've used hisax succesfully with a HFC PCI card and 2.4.20 kernel.

It's currently not expected to work. If you turn off some of the
still-cli-less TTY bits (fax, audio iirc) it may compile but in my
experience still just locks up hard on attempting to actually use it. 

-- 
dwmw2

