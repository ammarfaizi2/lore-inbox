Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265014AbUD2WmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265014AbUD2WmK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 18:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265017AbUD2WmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 18:42:10 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:27660 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S265014AbUD2WlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 18:41:22 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Marc Boucher <marc@linuxant.com>, Helge Hafting <helgehaf@aitel.hist.no>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Date: Fri, 30 Apr 2004 01:41:09 +0300
User-Agent: KMail/1.5.4
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040427165819.GA23961@valve.mbsi.ca> <408F99D5.1010900@aitel.hist.no> <3D29390A-992F-11D8-85DF-000A95BCAC26@linuxant.com>
In-Reply-To: <3D29390A-992F-11D8-85DF-000A95BCAC26@linuxant.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404300141.09497.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 April 2004 19:15, Marc Boucher wrote:

> > I believe you have to remove the \0 to operate legally (or release the
> > full source under the GPL for real.)
> > Your customer's problem is fixable though.  Either by also changing
> > the logging level
> > so the message doesn't go out on the console, or by patching the line
> > with that printk() out of your customer's kernel.
> > You can do this as a part of your install program.  If it gets too
> > hard, consider
> > supplying the customer with your own precompiled kernel.
>
> Thank you for the advice. However, if you knew our customers and
> understood their needs better you would realize that these are not
> feasible options.

I think you have to live with multiple warning messages,
at least until Rusty's patch propagate to mainline.
It's not fatal.
--
vda

