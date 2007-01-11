Return-Path: <linux-kernel-owner+w=401wt.eu-S932078AbXAKVPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbXAKVPt (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 16:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbXAKVPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 16:15:49 -0500
Received: from cantor2.suse.de ([195.135.220.15]:41695 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932080AbXAKVPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 16:15:48 -0500
Date: Thu, 11 Jan 2007 20:58:12 +0100
From: Stefan Seyfried <seife@suse.de>
To: emisca <emisca.ml@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, suspend2-users@lists.suspend2.net,
       suspend-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Suspend-devel] asus p5ld2 se, serial port gone after suspend and i8042 problems (solved, pnpacpi=off needed)
Message-ID: <20070111195812.GF11903@suse.de>
References: <414cba4e0701101409w4be38105vae7d185f4c2967bd@mail.gmail.com> <20070111114202.GC5945@elf.ucw.cz> <414cba4e0701110514t2fbd0659g905aa2fb06b9a261@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <414cba4e0701110514t2fbd0659g905aa2fb06b9a261@mail.gmail.com>
X-Operating-System: openSUSE 10.2 (i586), Kernel 2.6.18.2-34-default
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2007 at 02:14:42PM +0100, emisca wrote:
> Yes, I have to look at pnpacpi code... but does the dsdt matters for this
> problem?
> Surely, it is a bios bug (as usually.....). I will look at pnpacpi code.

Not necessarily. IIRC, somebody (Rusty?) said that serial consoles have had
problems with suspend for a long time and just sometimes work "by accident".
ISTR that they do not really save and restore the line settings etc.

So it does not need to be the BIOS, it can also be a plain broken driver.

-- 
Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg  | "Well, surrounding them's out." 
