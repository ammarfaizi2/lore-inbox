Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270530AbTHJS1u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 14:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270608AbTHJS1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 14:27:50 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:46567 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S270530AbTHJS1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 14:27:48 -0400
Date: Sun, 10 Aug 2003 20:27:41 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org
Subject: XMMS problems with recent 2.6 kernels and Wine
Message-ID: <20030810182741.GD16091@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I observe some problems with using Wine and recent 2.6 kernels.

System:
K6-2 @ 500 MHz
128 MB RAM
1 GB swap
Debian unstable

Workload:
XFree86
FVWM
XMMS
Wine running "Master of Orion 2" (a round based space strategy game)

With 2.4 kernels and 2.5.72 everything works fine.

With 2.6.0-test3 the XMMS sound sometimes sounds slow (like when wou 
manually retard a record).

With 2.6.0-test3-mm3 I observe something like a complete trashing, until
I suspend or kill Wine the system (including Wine) is completely
unusable, even simple movements of the mouse cursor sometimes take
several seconds to show an effect.

RAM usage is low, even after a "swapoff -a" at about half of my RAM
would be enough.

The problems might be related to the fact that after I start Wine three 
wine.bin processes run and each of them tries to get as much CPU time as 
possible.

I'm willing to help with encircling the problem if someone tells me what 
to search for.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

