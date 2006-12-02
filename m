Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936523AbWLBHp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936523AbWLBHp4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 02:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936561AbWLBHp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 02:45:56 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:49043 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S936523AbWLBHpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 02:45:55 -0500
Subject: Re: [RFC] Include ACPI DSDT from INITRD patch into mainline
From: Arjan van de Ven <arjan@infradead.org>
To: Ben Collins <ben.collins@ubuntu.com>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       Eric Piel <eric.piel@tremplin-utc>
In-Reply-To: <1165012538.5257.992.camel@gullible>
References: <1164998179.5257.953.camel@gullible>
	 <20061201185657.0b4b5af7@localhost.localdomain>
	 <1165001705.5257.959.camel@gullible>
	 <1165002345.3233.104.camel@laptopd505.fenrus.org>
	 <1165006868.5257.972.camel@gullible>
	 <1165009747.3233.108.camel@laptopd505.fenrus.org>
	 <1165012538.5257.992.camel@gullible>
Content-Type: text/plain
Organization: Intel International BV
Date: Sat, 02 Dec 2006 08:45:52 +0100
Message-Id: <1165045552.3233.132.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Providing object files for on-demand relinking of the kernel just adds a
> shit load of overhead. If you're suggesting modifying vmlinuz in place
> instead, that just seems really undesirable. Last thing I want is
> something mucking with the kernel binary.

... while randomly mucking with the bios content is something you do
want? While it's already *running* ? How much do you trust the end user
to himself randomly edit the AML code to force it to compile (usually
it's not more than that)?

> 
> It's easier for me to keep this patch in my tree, especially since most
> users have come to expect this as the "standard" method for inserting
> their DSDT replacement.

now here's another question... the ACPI layer got improved over the last
18 months bigtime to behave more like windows in many ways. How much of
this is still really needed? 

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

