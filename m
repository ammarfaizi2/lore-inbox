Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbUCKTQf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 14:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261531AbUCKTQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 14:16:35 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:43708 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S261440AbUCKTQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 14:16:34 -0500
Subject: Re: LKM rootkits in 2.6.x
From: Christophe Saout <christophe@saout.de>
To: Dave Jones <davej@redhat.com>
Cc: pg smith <pete@linuxbox.co.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20040311184835.GA21330@redhat.com>
References: <Pine.LNX.4.44.0403111124020.27770-100000@linuxbox.co.uk>
	 <20040311184835.GA21330@redhat.com>
Content-Type: text/plain
Message-Id: <1079032587.7517.1.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 11 Mar 2004 20:16:28 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Do, den 11.03.2004 schrieb Dave Jones um 19:48:

> Don't bet on it.  They'll just start doing what binary-only driver vendors
> have been doing for months.. If the table isn't exported, they find a symbol
> that is exported, and grovel around in memory near there until they find
> something that looks like it, and patch accordingly.

Ugh... this sounds ugly. This should be forbidden. I mean, what are
things like EXPORT_SYMBOL_GPL for if drivers are allowed to patch
whatever they want?


