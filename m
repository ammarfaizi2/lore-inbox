Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbTIZRrc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 13:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbTIZRrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 13:47:32 -0400
Received: from 213-187-164-3.dd.nextgentel.com ([213.187.164.3]:8454 "EHLO
	ford.pronto.tv") by vger.kernel.org with ESMTP id S261491AbTIZRra
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 13:47:30 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Michael Frank <mhf@linuxmail.org>, andre@linux-ide.org,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG?] SIS IDE DMA errors
References: <yw1x7k3vlokf.fsf@users.sourceforge.net>
	<200309262208.30582.mhf@linuxmail.org>
	<yw1x3cejlk34.fsf@users.sourceforge.net>
	<200309262332.30091.mhf@linuxmail.org> <20030926165957.GA11150@ucw.cz>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Fri, 26 Sep 2003 19:27:35 +0200
In-Reply-To: <20030926165957.GA11150@ucw.cz> (Vojtech Pavlik's message of
 "Fri, 26 Sep 2003 18:59:57 +0200")
Message-ID: <yw1x7k3vjw8o.fsf@users.sourceforge.net>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> writes:

> Actually, it's me who wrote the 961 and 963 support. It works fine for
> most people. Did you check you cabling?

I'm dealing with a laptop, but I suppose I could wiggle the cables a
bit.  I still doubt it's a cable problem, since reading works
flawlessly.

It appears to me that during heavy IO load, some DMA interrupts get
lost, for some reason.

-- 
Måns Rullgård
mru@users.sf.net
