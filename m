Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131711AbRCONhF>; Thu, 15 Mar 2001 08:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131712AbRCONgz>; Thu, 15 Mar 2001 08:36:55 -0500
Received: from gherkin.sa.wlk.com ([192.158.254.49]:15876 "HELO
	gherkin.sa.wlk.com") by vger.kernel.org with SMTP
	id <S131711AbRCONgt>; Thu, 15 Mar 2001 08:36:49 -0500
Message-Id: <m14dXth-0005kiC@gherkin.sa.wlk.com>
From: rct@gherkin.sa.wlk.com (Bob_Tracy)
Subject: Re: another Cyrix/mtrr problem?
In-Reply-To: <y7ru24wuffy.fsf@sytry.doc.ic.ac.uk> "from David Wragg at Mar 14,
 2001 10:57:21 pm"
To: David Wragg <dpw@doc.ic.ac.uk>
Date: Thu, 15 Mar 2001 07:34:33 -0600 (CST)
CC: dieder@ibr.cs.tu-bs.de, davej@suse.de, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Wragg wrote:
> rct@gherkin.sa.wlk.com (Bob_Tracy) writes:
> > echo "base=0xd8000000 size=0x100000 type=write-combining" >| /proc/mtrr
> > 
> > I get a 2MB region instead of the 1MB region I expected...
> 
> Oops, it got broken by the MTRR >32-bit support in 2.4.0-testX.  The
> patch below should fix it.
> 
> Joerg, I think this might well fix your Cyrix mtrr problem also.
> 
> Let me know how it goes,

That fixed the "wrong size" problem nicely.  Thanks!

AGP support on this beast (Tyan S1590S / Apollo MVP3) is still broken,
however.  I'll try the new NVIDIA driver (as someone suggested -- thanks
for the steer!) and see if that helps.  If there's an NVIDIA person
reading this that would like to work this issue off-line, your help
would be appreciated.  Thanks!

-- Bob Tracy
rct@frus.com
