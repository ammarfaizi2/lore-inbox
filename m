Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273442AbRI0PtR>; Thu, 27 Sep 2001 11:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273414AbRI0Ps5>; Thu, 27 Sep 2001 11:48:57 -0400
Received: from mailout00.sul.t-online.com ([194.25.134.16]:18645 "EHLO
	mailout00.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S273424AbRI0Psw>; Thu, 27 Sep 2001 11:48:52 -0400
Date: Thu, 27 Sep 2001 17:48:57 +0200
From: Marc Schiffbauer <marc.schiffbauer@links2linux.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10 (SMP, highmem) solid freeze
Message-ID: <20010927174857.A26656@lisa.links2linux.home>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <15282.60654.52083.446184@proizd.camtp.uni-mb.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15282.60654.52083.446184@proizd.camtp.uni-mb.si>; from igor.mozetic@uni-mb.si on Thu, Sep 27, 2001 at 11:10:06AM +0200
X-Operating-System: Linux 2.4.7 i586
X-Editor: VIM 5.7.8
X-Homepage: http://www.links2linux.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Igor Mozetic schrieb am 27.09.01 um 11:10 Uhr:
> After two days of uptime under load 2-3 (no swapping, not much I/O),
> the box froze completely. Only hard reboot brought it back.
> Nothing in logs, sorry ...
> Hardware seems OK, other machines (UP, no highmem) run fine so far.
> 
> Hardware:
> dual Xeon 550Mhz, C440GX+, 2GB RAM, 1GB swap, SCSI AIC-7896/7
> 

Hi Igor,

try to disable swap. Or use swap size >= 2* ram.
I had some lockups (SMP, 2GB too) on Kernel 2.4.3-pre3 after some
days until I disabled swap completely since it was not needed... now
the machines are stable.

-Marc

-- 
BUGS My programs  never  have  bugs.  They  just  develop  random
     features.  If you discover such a feature and you want it to
     be removed: please send an email to bug@links2linux.de 
