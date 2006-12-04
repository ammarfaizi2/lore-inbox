Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936043AbWLDL3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936043AbWLDL3x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 06:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936044AbWLDL3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 06:29:53 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:35723 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S936043AbWLDL3w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 06:29:52 -0500
Date: Mon, 4 Dec 2006 11:58:46 +0100
From: Stefan Seyfried <seife@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       Ben Collins <ben.collins@ubuntu.com>
Subject: Re: [RFC] Include ACPI DSDT from INITRD patch into mainline
Message-ID: <20061204105846.GA17953@suse.de>
References: <1164998179.5257.953.camel@gullible> <20061201185657.0b4b5af7@localhost.localdomain> <1165001705.5257.959.camel@gullible> <1165002345.3233.104.camel@laptopd505.fenrus.org> <1165006868.5257.972.camel@gullible> <1165009747.3233.108.camel@laptopd505.fenrus.org> <1165012538.5257.992.camel@gullible> <1165045552.3233.132.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1165045552.3233.132.camel@laptopd505.fenrus.org>
X-Operating-System: openSUSE 10.2 (i586), Kernel 2.6.18.2-34-default
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2006 at 08:45:52AM +0100, Arjan van de Ven wrote:

> now here's another question...

And a good one, indeed.

> the ACPI layer got improved over the last
> 18 months bigtime to behave more like windows in many ways. How much of
> this is still really needed? 

I have not used a machine that really needed this for quite some time now.
Usually even DSDTs that do not pass the "disassemble, then recompile with
iasl"-test seem to work much better in practice than they did before.

And seeing what stupid ideas people come up with (sharing DSDTs on
acpi.sf.net _is_ stupid, since the DSDT usually depends on things you
configured in your BIOS settings, memory size, etc.pp) it is probably
a good idea to keep this patch out of mainline.

It is usefull for debugging, sure, but somebody who can debug on this
level should also be able to patch his kernel :-)
-- 
Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg  | "Well, surrounding them's out." 
