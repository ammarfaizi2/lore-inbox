Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317261AbSF1N2y>; Fri, 28 Jun 2002 09:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317262AbSF1N2x>; Fri, 28 Jun 2002 09:28:53 -0400
Received: from lech.pse.pl ([194.92.3.7]:57252 "EHLO lech.pse.pl")
	by vger.kernel.org with ESMTP id <S317261AbSF1N2w>;
	Fri, 28 Jun 2002 09:28:52 -0400
Date: Fri, 28 Jun 2002 15:30:52 +0200
From: Lech Szychowski <lech.szychowski@pse.pl>
To: "Lists (lst)" <linux@lapd.cj.edu.ro>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IRQ sharing problem - 2.4.18 kernel
Message-ID: <20020628133052.GA9786@lech.pse.pl>
Reply-To: Lech Szychowski <lech.szychowski@pse.pl>
Mail-Followup-To: "Lists (lst)" <linux@lapd.cj.edu.ro>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.43L0.0206281119490.14586-100000@lapd.cj.edu.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.43L0.0206281119490.14586-100000@lapd.cj.edu.ro>
Organization: Polskie Sieci Elektroenergetyczne S.A.
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
> I have a TYAN Tiger 200T M/B with 2xIntel PIII CPUs at 1GHz and 1,3GB RAM. 
> I'm using RadHat up to date and 2.4.18 vanilla kernel. On heavy load on 
> ethernet interfaces (eth1,2,3,4) and scsi controller which are on the same 
> IRQ (11) my server stops responding.
[...]
>  11:       8984       9458   IO-APIC-level  ncr53c8xx, eth1, eth2, eth3, eth4
>  Here is my problem			    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Is this a Tulip NIC? If so, have you tried using the de4x5 driver
rather than the tulip one?

-- 
	Leszek.

-- lech7@pse.pl 2:480/33.7          -- REAL programmers use INTEGERS --
-- speaking just for myself...
