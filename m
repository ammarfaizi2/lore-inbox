Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262190AbVDFMmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbVDFMmw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 08:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbVDFMmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 08:42:12 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:2982 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S262201AbVDFMj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 08:39:58 -0400
Date: Wed, 6 Apr 2005 14:39:47 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] Re: It's getting worse: 2.6.12-rc2-mm1 and suspend2ram
Message-ID: <20050406123947.GA31958@gamma.logic.tuwien.ac.at>
References: <20050405181628.GB6879@gamma.logic.tuwien.ac.at> <20050405204107.GD1380@elf.ucw.cz> <20050405210041.GA16263@gamma.logic.tuwien.ac.at> <20050405211340.GF1380@elf.ucw.cz> <20050405221903.GA21196@gamma.logic.tuwien.ac.at> <20050405183144.50ed3a9c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050405183144.50ed3a9c.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Die, 05 Apr 2005, Andrew Morton wrote:
> > 2.6.12-rc2 suspends and resumes with the very same config file (well,
> > after running make oldconfig) without any problem.
> > 
> > So there is a change in -mm1 which triggers this. Should I start with
> > backing out bk-acpi? or anything else?
> 
> bk-acpi would be a good choice.  It might be easier to start with
> 2.6.12-rc2 and add stuff, see when it breaks.

Ok, 
	2.6.12-rc2		suspend and resumes works
	   + bk-acpi.patch	immediate reboot at resume.

> bk-acpi and bk-driver-core would be prime suspects.

I didn't try bk-driver-core.

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining AT logic DOT at>             Università di Siena
sip:preining@at43.tuwien.ac.at                             +43 (0) 59966-690018
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
SCREEB (n.)
To make the noise of a nylon anorak rubbing against a pair of corduroy
trousers.
			--- Douglas Adams, The Meaning of Liff
