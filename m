Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264534AbUBIBN2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 20:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264537AbUBIBN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 20:13:27 -0500
Received: from fep03-svc.mail.telepac.pt ([194.65.5.202]:31167 "EHLO
	fep03-svc.mail.telepac.pt") by vger.kernel.org with ESMTP
	id S264534AbUBIBN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 20:13:26 -0500
From: Claudio Martins <ctpm@rnl.ist.utl.pt>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [patch] Re: psmouse.c, throwing 3 bytes away
Date: Mon, 9 Feb 2004 01:13:23 +0000
User-Agent: KMail/1.5.4
References: <200402041820.39742.wnelsonjr@comcast.net> <200402070911.42569.murilo_pontes@yahoo.com.br> <20040209004812.GA18512@ucw.cz>
In-Reply-To: <20040209004812.GA18512@ucw.cz>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402090113.23609.ctpm@rnl.ist.utl.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Just FYI:

  CC      drivers/input/serio/i8042.o
drivers/input/serio/i8042.c: In function `i8042_interrupt':
drivers/input/serio/i8042.c:378: warning: `data' might be used uninitialized 
in this function

regards

Claudio


On Monday 09 February 2004 00:48, Vojtech Pavlik wrote:
> On Sat, Feb 07, 2004 at 09:11:42AM +0000, Murilo Pontes wrote:
> > Problem still occurs :-(
>
> And here is a fix. Damn stupid mistake I made.

