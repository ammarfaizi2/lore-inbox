Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265062AbTFCPvW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 11:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265063AbTFCPvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 11:51:22 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:39659 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S265062AbTFCPvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 11:51:19 -0400
Date: Tue, 3 Jun 2003 13:02:45 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Marc Wilson <msw@cox.net>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc6
In-Reply-To: <20030529055735.GB1566@moonkingdom.net>
Message-ID: <Pine.LNX.4.55L.0306031302310.3892@freak.distro.conectiva>
References: <20030529052425.GA1566@moonkingdom.net>
 <BKEGKPICNAKILKJKMHCAIEANECAA.Riley@Williams.Name> <20030529055735.GB1566@moonkingdom.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 28 May 2003, Marc Wilson wrote:

> On Thu, May 29, 2003 at 06:34:48AM +0100, Riley Williams wrote:
> > The basic problem there is that any mail client needs to know
> > just how many messages are in a particular folder to handle that
> > folder, and the only way to do this is to count them all. That's
> > what takes the time when one opens a large folder.
>
> No, the basic problem there is that the kernel is deadlocking.  Read the
> VERY long thread for the details.
>
> I think I have enough on the ball to be able to tell the difference between
> mutt opening a folder and counting messages, with a counter and percentage
> indicator advancing, and mutt sitting there deadlocked with the HD activity
> light stuck on and all the rest of X stuck tight.
>
> And it just happened again, so -rc6 is no sure fix.  What did y'all that
> reported the problem had gone away do, patch -rc4 with the akpm patches?
> ^_^

Ok, so you can reproduce the hangs reliably EVEN with -rc6, Marc?
