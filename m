Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbTEFCLx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 22:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbTEFCLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 22:11:52 -0400
Received: from inpbox.inp.nsk.su ([193.124.167.24]:16803 "EHLO
	inpbox.inp.nsk.su") by vger.kernel.org with ESMTP id S262256AbTEFCLw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 22:11:52 -0400
Date: Tue, 6 May 2003 09:17:22 +0700
From: "Dmitry A. Fedorov" <D.A.Fedorov@inp.nsk.su>
Reply-To: D.A.Fedorov@inp.nsk.su
To: Pete Zaitcev <zaitcev@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: The disappearing sys_call_table export.
In-Reply-To: <200305052050.h45KojH30693@devserv.devel.redhat.com>
Message-ID: <Pine.SGI.4.10.10305060911400.7773473-100000@Sky.inp.nsk.su>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 May 2003, Pete Zaitcev wrote:

> > for creating/deleting /dev entries dynamically on driver
> > loading/unloading. It allows me to acquire dynamic major
> > number without devfs and external utility of any kind.
> 
> Well, duh. "Without devds and external utility" is a no-goal.
> You set it, you screw trying to achieve it. It's like a well-known
> Russian joke: "[...] We remove the adenoid tissue... through
> the anal opening with a blowtorch".

:)
I disagree. It is small and nice solution. It is my own devfs for
pre-devfs kernels.

> > I use sys_write to output loading/device detection/diagnostic
> > messages to process's stderr when appropriate. Yes, it may look as
> > "wrong thing" but it uses only legal kernel mechanisms and it saves
> > lots of time with e-mail support:
> > /sbin/insmod driver verbose=1 2>&1 | mail -s 'it does not works' me@
> 
> And pray tell how is syslog different?

syslog has the same text first.

