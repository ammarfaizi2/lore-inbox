Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288174AbSA3Cw0>; Tue, 29 Jan 2002 21:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288173AbSA3CwR>; Tue, 29 Jan 2002 21:52:17 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:60936 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S288114AbSA3CwG>; Tue, 29 Jan 2002 21:52:06 -0500
Date: Wed, 30 Jan 2002 02:51:47 +0000
From: John Levon <movement@marcelothewonderpenguin.com>
To: linux-kernel@vger.kernel.org
Cc: bsprunt@bucknell.edu
Subject: Re: installing an APIC interrupt handler w/o patching the kernel?
Message-ID: <20020130025147.GA95029@compsoc.man.ac.uk>
In-Reply-To: <5.1.0.14.2.20020129095621.02268288@mail.bucknell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20020129095621.02268288@mail.bucknell.edu>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Bendik Singers - Afrotid
X-Toppers: N/A
X-Scanner: exiscan *16Vkqp-000COJ-00*v0KTVCbHWEo* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2002 at 10:17:14AM -0500, Brinkley Sprunt wrote:

> Is there a recommended way to install an APIC interrupt handler without
> patching the kernel?

You can set it to NMI delivery and do a horrible hack to install a new IDT
entry. You might want to talk to Gareth Hughes, btw.

regards
john

-- 
"In no sense is [in]stability a reason to move to a new version. It's never a
reason."
	- Bill Gates
