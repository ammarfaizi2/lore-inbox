Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264933AbUBILaa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 06:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264942AbUBILaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 06:30:30 -0500
Received: from dsl-213-023-011-014.arcor-ip.net ([213.23.11.14]:58341 "EHLO
	fusebox.fsfeurope.org") by vger.kernel.org with ESMTP
	id S264933AbUBILa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 06:30:27 -0500
To: linux-kernel@vger.kernel.org
Cc: Matthias Hentges <mailinglisten@hentges.net>,
       acpi-devel@lists.sourceforge.net
Subject: Re: [PROBLEM] 2.6.3-rc1: still no suspend/resume on Centrino
From: "Georg C. F. Greve" <greve@gnu.org>
Organisation: Free Software Foundation Europe - GNU Project
X-PGP-Fingerprint: 2D68 D553 70E5 CCF9 75F4 9CC9 6EF8 AFC2 8657 4ACA
X-PGP-Affinity: will accept encrypted messages for GNU Privacy Guard
X-Home-Page: http://gnuhh.org
X-Accept-Language: en, de
In-Reply-To: <1076282567.6594.3.camel@mhcln03>
References: <1076282567.6594.3.camel@mhcln03>
Date: Mon, 09 Feb 2004 12:30:08 +0100
Message-ID: <m3n07s4hj3.fsf@reason.gnu-hamburg>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 > Well my laptop uses the 855PM chipset and it does *not*
 > work. Suspend works but the machine won't wake up (drives power up
 > but the screen stays blank and the machine is not pingable.

Thanks for pointing that out, it sounds a lot like the problem
description of the 855GM machines.

So according to the data posted on the net/in the lists, the status of
kernel 2.6.x advanced power management (suspend/resume) on Centrino
notebooks depending on the chipset currently looks like

 Intel 855GM:  no success story so far

 Intel 855PM:  a few successes reported, definitely not true for all

 Intel 855GME: ??? (no data)

Regards,
Georg


P.S. I'm curious: I know some Intel employees are working on the Linux
ACPI code, is this merely tolerated or officially during paid time?
Are you given any preferences what to work on or are you entirely free
in your prioritizing?

-- 
Georg C. F. Greve                                       <greve@gnu.org>
Free Software Foundation Europe	                 (http://fsfeurope.org)
Brave GNU World	                           (http://brave-gnu-world.org)
