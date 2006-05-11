Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030255AbWEKP2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030255AbWEKP2Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 11:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030256AbWEKP2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 11:28:16 -0400
Received: from chiark.greenend.org.uk ([193.201.200.170]:3729 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S1030255AbWEKP2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 11:28:16 -0400
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
CC: Dave Jones <davej@redhat.com>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, trenn@suse.de,
       Greg KH <gregkh@suse.de>, thoenig@suse.de
Subject: Re: [RFC] [PATCH] Execute PCI quirks on resume from suspend-to-RAM
In-Reply-To: <4463556C.3040107@gmx.net>
References: <446139FF.205@gmx.net> <20060510093942.GA12259@elf.ucw.cz> <4461C0CA.8080803@gmx.net> <20060510205600.GB23446@suse.de> <44625CE9.2060204@gmx.net> <20060511023109.GB11693@redhat.com> <4462B737.80108@gmx.net> <4462B737.80108@gmx.net> <4463556C.3040107@gmx.net>
Date: Thu, 11 May 2006 16:28:11 +0100
Message-Id: <E1FeD5H-0003tn-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net> wrote:

> +#ifndef CONFIG_SOFTWARE_SUSPEND

ACPI_SLEEP doesn't depend on SOFTWARE_SUSPEND, so this looks like the 
wrong fix.

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
