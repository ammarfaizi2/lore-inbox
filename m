Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbTLWRfu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 12:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbTLWRfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 12:35:50 -0500
Received: from iron-c-1.tiscali.it ([212.123.84.81]:10802 "EHLO
	mailr-1.tiscali.it") by vger.kernel.org with ESMTP id S261973AbTLWRfs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 12:35:48 -0500
X-BrightmailFiltered: true
Date: Tue, 23 Dec 2003 18:35:56 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Cc: Bill Nottingham <notting@redhat.com>
Subject: Re: various issues with ACPI sleep and 2.6
Message-ID: <20031223173556.GA9412@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031223165739.GA28356@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Testing ACPI sleep under 2.6, I noticed the following issues
> (Thinkpad T40, i855PM chipset):
>
> - USB fails on resume (sent to linux-usb-devel)

Known issue. Unload usb modules before suspending.

> - DRI being loaded at all causes X to fail on resume

Known issue. See
http://dri.sourceforge.net/cgi-bin/moin.cgi/PowerManagement

> - MCE on resume:
>
>  MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
>  Bank 1: f200000000000175

Hum, this is strange. I saw similar  messages on my laptop but they were
related to bank0-issue on athlon CPUs. No idea of what's going on there.

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Windows /win'dohz/ n. : thirty-two  bit extension and graphical shell to
a sixteen  bit patch to an  eight bit operating system  originally coded
for a  four bit microprocessor  which was  written by a  two-bit company
that can't stand a bit of competition.
