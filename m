Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261920AbVBOWls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbVBOWls (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 17:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbVBOWkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 17:40:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:40088 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261920AbVBOWi6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 17:38:58 -0500
X-Authenticated: #26200865
Message-ID: <42127A65.3090104@gmx.net>
Date: Tue, 15 Feb 2005 23:40:37 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.2) Gecko/20040906
X-Accept-Language: de, en
MIME-Version: 1.0
To: Matthew Garrett <mjg59@srcf.ucam.org>
CC: Norbert Preining <preining@logic.at>, Pavel Machek <pavel@suse.cz>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
Subject: Re: [ACPI] Call for help: list of machines with working S3
References: <20050214211105.GA12808@elf.ucw.cz>	 <20050215125555.GD16394@gamma.logic.tuwien.ac.at>	 <42121EC5.8000004@gmx.net> <20050215170837.GA6336@gamma.logic.tuwien.ac.at>	 <4212460A.4000100@gmx.net> <1108498875.12026.18.camel@elrond.flymine.org>
In-Reply-To: <1108498875.12026.18.camel@elrond.flymine.org>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Garrett schrieb:
> On Tue, 2005-02-15 at 19:57 +0100, Carl-Daniel Hailfinger wrote:
> 
> 
>>Kendall Bennett is working with me to get suspend/resume working
>>even with framebuffers. Once we have results, I'll post them here.
> 
> 
> I've had success using vesafb with vbetool state restoration. vga16fb
> ought to work fairly happily.

Well, in my testing the machine deadlocked if any framebuffer was
active during resume. It even deadlocked *before* I could run vbetool.


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
