Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbWEPJhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWEPJhF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 05:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751717AbWEPJhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 05:37:04 -0400
Received: from mail-a01.ithnet.com ([217.64.83.96]:29343 "HELO ithnet.com")
	by vger.kernel.org with SMTP id S1750747AbWEPJhC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 05:37:02 -0400
X-Sender-Authentication: net64
Date: Tue, 16 May 2006 11:37:00 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: thockin@hockin.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: mcelog ?
Message-Id: <20060516113700.15733892.skraw@ithnet.com>
In-Reply-To: <20060515152008.GA25367@hockin.org>
References: <20060515114243.8ccaa9aa.skraw@ithnet.com>
	<20060515152008.GA25367@hockin.org>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 May 2006 08:20:08 -0700
thockin@hockin.org wrote:

> On Mon, May 15, 2006 at 11:42:43AM +0200, Stephan von Krawczynski wrote:
> > HARDWARE ERROR
> > CPU 1: Machine Check Exception:                4 Bank 4: b60a200170080813
> > TSC 89cfb4725b17 ADDR 1025cb3f0 
> > This is not a software problem!
> > Run through mcelog --ascii to decode and contact your hardware vendor
> > Kernel panic - not syncing: Machine check
> > 
> > Of course I ran mcelog but I don't quite understand how the additional info
> > helps me finding the problem.
> > Is this a problem with RAM? And if, which one?
> 
> It sounds like a memory error, but there are some other bank4 errors that
> can crop up.  What does mcedecode say?

Well, here it is:

HARDWARE ERROR
CPU 1 4 northbridge TSC 89cfb4725b17 
  Northbridge Chipkill ECC error
  Chipkill ECC syndrome = 7014
       bit32 = err cpu0
       bit45 = uncorrected ecc error
       bit57 = processor context corrupt
       bit61 = error uncorrected
  bus error 'local node origin, request didn't time out
      generic read mem transaction
      memory access, level generic'
STATUS b60a200170080813 MCGSTATUS 4
This is not a software problem!

 
Is this some sort of mem error?

Thank you for your help
-- 
Regards,
Stephan
