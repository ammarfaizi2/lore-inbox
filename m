Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130485AbRECPEt>; Thu, 3 May 2001 11:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131244AbRECPEj>; Thu, 3 May 2001 11:04:39 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:38667 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S130532AbRECPE3>; Thu, 3 May 2001 11:04:29 -0400
Date: Thu, 3 May 2001 17:04:27 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Success, aic7xxx 6.1.13 fixes boot problems in 2.4.3 2.4.4pre8 2.4.4 (was: 2.4.3 2.4.4pre8: aic7xxx showstopper bug fails to detect sda)
Message-ID: <20010503170427.A25904@burns.dt.e-technik.uni-dortmund.de>
Mail-Followup-To: "Justin T. Gibbs" <gibbs@scsiguy.com>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20010430013956.A1578@emma1.emma.line.org> <200105020431.f424VPs81767@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200105020431.f424VPs81767@aslan.scsiguy.com>; from gibbs@scsiguy.com on Tue, May 01, 2001 at 22:31:25 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 May 2001, Justin T. Gibbs wrote:

> Version 6.1.13 of my aic7xxx driver is now up.  I've included
> patches to 2.4.4 and 2.4.4-ac2.  If this version still causes
> problems for you, please boot with "aic7xxx=verbose" and send
> me any diagnostic output the driver prints.  I'll try to correct
> your issue as quickly as I can.

Okay, I finally got one of the workstations that failed and I was able
to try your 6.1.13 driver (on top of 2.4.4). 6.1.13 fixes the problem
that vanilla 2.4.4 gave me upon boot, in that it properly detects all
SCSI devices, the first disk as well (that was a problem formerly).

Thanks a lot. (Might it be a good idea to ask Linus and Alan to update the
driver they ship in 2.4.5-pre or 2.4.4-ac, respectively?)

-- 
Matthias Andree
