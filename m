Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbTLWR7J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 12:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbTLWR7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 12:59:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:3248 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262098AbTLWR7F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 12:59:05 -0500
Date: Tue, 23 Dec 2003 12:58:48 -0500
From: Bill Nottingham <notting@redhat.com>
To: Kronos <kronos@kronoz.cjb.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: various issues with ACPI sleep and 2.6
Message-ID: <20031223175848.GA30037@devserv.devel.redhat.com>
Mail-Followup-To: Kronos <kronos@kronoz.cjb.net>,
	linux-kernel@vger.kernel.org
References: <20031223165739.GA28356@devserv.devel.redhat.com> <20031223173556.GA9412@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031223173556.GA9412@dreamland.darkstar.lan>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kronos (kronos@kronoz.cjb.net) said: 
> > - DRI being loaded at all causes X to fail on resume
> 
> Known issue. See
> http://dri.sourceforge.net/cgi-bin/moin.cgi/PowerManagement

Yes, with the patch there, suspend/resume of running DRI apps works
fine, even without switching VTs as suggested. 

> > - MCE on resume:
> >
> >  MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
> >  Bank 1: f200000000000175
> 
> Hum, this is strange. I saw similar  messages on my laptop but they were
> related to bank0-issue on athlon CPUs. No idea of what's going on there.

I saw a report of this occuring with APM suspend as well for one person
on a T40; may or may not be related.

Bill
