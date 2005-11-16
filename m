Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030374AbVKPPcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030374AbVKPPcQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 10:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030362AbVKPPcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 10:32:16 -0500
Received: from main.gmane.org ([80.91.229.2]:1444 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030374AbVKPPcO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 10:32:14 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Pasi Savolainen <psavo@iki.fi>
Subject: Re: 2.6.14 X spinning in the kernel
Date: Wed, 16 Nov 2005 15:24:10 +0000 (UTC)
Message-ID: <slrndnmjor.1ff.psavo@varg.dyndns.org>
References: <1132012281.24066.36.camel@localhost.localdomain>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a11a.mannikko1.ton.tut.fi
X-Face: $sk2zxhxVp'QPUj~kr+z:<m>#+84DO\Ab{4Hes1.P>]p=XhgsnwZM^[:"M?W#_x{W5[lu7i bqv7lOL`]5G%fH"Pgd5;+t"w)sOPDg::&T$Z9p#|xSMIb`$Udj6u14lh]imQ\z
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Badari Pulavarty <pbadari@us.ibm.com>:
> Hi,
>
> My 2-cpu EM64T machine started showing this problem again on 2.6.14.
> On some reboots, X seems to spin in the kernel forever.
>
> sysrq-t output shows nothing.
>
> X             R  running task       0  3607   3589          3903
> (L-TLB)
>
> top shows:
>  3607 root      25   0     0    0    0 R 99.1  0.0 262:04.69 X


I get something like than on 2xAthlon, but kernel 2.6.12 (some debian
version, AFAIK slightly patched). In my case XOrg (6.8.2 -> 6.9-rc)
doesn't hang but continues to work, I notice other hung process from
rising load.
Video card is Radeon 9200. When I restart X (logout to gdm), hung
process disappears.

-- 
   Psi -- <http://www.iki.fi/pasi.savolainen>

