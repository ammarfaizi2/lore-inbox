Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261309AbUKBSq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbUKBSq1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 13:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbUKBSq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 13:46:27 -0500
Received: from gate.firmix.at ([80.109.18.208]:33207 "EHLO gate.firmix.at")
	by vger.kernel.org with ESMTP id S261309AbUKBSqU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 13:46:20 -0500
Subject: Re: [oops] lib/vsprintf.c
From: Bernd Petrovitsch <bernd@firmix.at>
To: =?iso-8859-2?Q?Pawe=B3?= Sikora <pluto@pld-linux.org>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
In-Reply-To: <200411021934.38802.pluto@pld-linux.org>
References: <200411020719.55570.pluto@pld-linux.org>
	 <Pine.LNX.4.53.0411020802410.13921@yvahk01.tjqt.qr>
	 <200411021934.38802.pluto@pld-linux.org>
Content-Type: text/plain; charset=iso-8859-2
Organization: Firmix Software GmbH
Message-Id: <1099421176.10957.3.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.5 
Date: Tue, 02 Nov 2004 19:46:16 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-02 at 19:34 +0100, Pawe³ Sikora wrote:
> On Tuesday 02 of November 2004 08:03, you wrote:
> > >static int km_init_module(void)
> > >{
> > >    printk(KERN_DEBUG "%s init\n", 1.4);
> > >    return 0;
> > >}
> >
> > You do know that %s does not mix with 1.4?
> 
> Yes, I known. I did it intentionally.

"Doctor, it hurts when I do that."
"Then do not do it."

> IMHO kernel should be more resistant to accidental programmers errors.

What for? Simply fix them immediately.

> Be secure, trust no one ;)

ACK. Therefore the kernel oopses, rendering the machine useless for the
moment and forces the programmer to look for the bug.

> ... and catch bugs with http://netlab.ru.is/exception/KernelExceptions.pdf

What should happen afterwards?
Write a line to syslog which is probably ignored anyway?

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

