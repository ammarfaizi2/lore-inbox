Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263717AbTHWWDS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 18:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263682AbTHWWDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 18:03:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37646 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263717AbTHWWDL (ORCPT
	<rfc822;linux-kernel@vger.redhat.com>);
	Sat, 23 Aug 2003 18:03:11 -0400
Date: Sun, 24 Aug 2003 00:04:38 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: LKML <linux-kernel@vger.redhat.com>
Subject: Re: 2.6.0-test4 - lost ACPI
Message-ID: <20030823220438.GB1155@irc.pl>
Mail-Followup-To: Tomasz Torcz <zdzichu@irc.pl>,
	LKML <linux-kernel@vger.redhat.com>
References: <20030823105243.GA1245@irc.pl> <20030823145545.2b7d6ec9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030823145545.2b7d6ec9.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 23, 2003 at 02:55:45PM -0700, Andrew Morton wrote:
> Tomasz Torcz <zdzichu@irc.pl> wrote:
> 
> >  ACPI disabled because your bios is from 00 and too old
> >  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Add "acpi=force" to your kernel boot command line and everything should work
> as before.

It does not work. It halts in beetween ps/2 mouse init and serio init.
Adding "acpi=force pci=noacpi" solves that.

-- 
Tomasz Torcz               RIP is irrevelant. Spoofing is futile.
zdzichu@irc.-nie.spam-.pl     Your routes will be aggreggated. -- Alex Yuriev
