Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264979AbUEYREt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264979AbUEYREt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 13:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264980AbUEYREt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 13:04:49 -0400
Received: from poup.poupinou.org ([195.101.94.96]:4408 "EHLO poup.poupinou.org")
	by vger.kernel.org with ESMTP id S264973AbUEYRE3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 13:04:29 -0400
Date: Tue, 25 May 2004 19:04:14 +0200
To: Manuel Kasten <kasten.m@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [speedste-centrino] couldn't enable Enhanced SpeedStep
Message-ID: <20040525170414.GB10063@poupinou.org>
References: <200405231126.11815.kasten.m@gmx.de> <20040525145259.GA10063@poupinou.org> <200405251715.40529.kasten.m@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405251715.40529.kasten.m@gmx.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Bruno Ducrot <poup@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 25, 2004 at 05:15:40PM +0200, Manuel Kasten wrote:
> Hello,
> 
> > Could you please try with CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI
> > enabled?  Sometimes, the BIOS would require that the OS take
> > ownership of the performance stuff..
> 
> I have done that already. The only change is, that he won't report 
> "found: Intel(R) Pentium(R) M processor 1500MHz". The line with 
> "couldn't enable Enhanced SpeedStep" remains unchanged.

Could you please send me privately the output of acpidmp?

wget ftp://ftp.kernel.org//pub/linux/kernel/people/lenb/acpi/utils/pmtools-20031210.tar.bz2
tar xjvfp pmtools-20031210.tar.bz2
cd pmtools-20031210/acpidmp
make
sudo ./acpidmp > acpidmp.out
bzip2 acpidmp.out 

Cheers,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
