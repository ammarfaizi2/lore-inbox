Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314885AbSE0JUl>; Mon, 27 May 2002 05:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314981AbSE0JUk>; Mon, 27 May 2002 05:20:40 -0400
Received: from ns.suse.de ([213.95.15.193]:65292 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S314885AbSE0JUj>;
	Mon, 27 May 2002 05:20:39 -0400
Date: Mon, 27 May 2002 11:20:39 +0200
From: Dave Jones <davej@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Trivial: move PCI ID definitions from ide-pci.c to pci_ids.h
Message-ID: <20020527112039.R16102@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Martin Dalecki <dalecki@evision-ventures.com>,
	Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <20020526152204.A18812@ucw.cz> <3CF1E7C0.9090909@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2002 at 10:01:04AM +0200, Martin Dalecki wrote:
 > Please note that pci_ids.h. is a generated file.

No. You're thinking of drivers/pci/devlist.h and classlist.h
If you looks at pci_ids.h, you'll notice we only have IDs in there
for devices Linux actually supports.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
