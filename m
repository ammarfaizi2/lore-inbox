Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262583AbUKEDMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262583AbUKEDMu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 22:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262582AbUKEDMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 22:12:50 -0500
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:20742 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S262585AbUKEDMo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 22:12:44 -0500
To: Elladan <elladan@eskimo.com>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Russell Miller <rmiller@duskglow.com>,
       Doug McNaught <doug@mcnaught.org>, Jim Nelson <james4765@verizon.net>,
       DervishD <lkml@dervishd.net>, Gene Heskett <gene.heskett@verizon.net>,
       linux-kernel@vger.kernel.org, M?ns Rullg?rd <mru@inprovide.com>
From: Tim Connors <tconnors+linuxkernel1099624161@astro.swin.edu.au>
Subject: Re: is killing zombies possible w/o a reboot?
In-reply-to: <20041105023850.GC17010@eskimo.com>
References: <200411030751.39578.gene.heskett@verizon.net> <87k6t24jsr.fsf@asmodeus.mcnaught.org> <200411031733.30469.rmiller@duskglow.com> <200411040839.34350.vda@port.imtp.ilyichevsk.odessa.ua> <20041105023850.GC17010@eskimo.com>
X-test-to: Elladan <elladan@eskimo.com>
X-cc-to: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>, Russell Miller <rmiller@duskglow.com>, Doug McNaught <doug@mcnaught.org>, Jim Nelson <james4765@verizon.net>, DervishD <lkml@dervishd.net>, Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org, M?ns Rullg?rd <mru@inprovide.com>
X-reply-to-bofh-messageid: <2X2kV-1Ji-21@gated-at.bofh.it>
X-Face: "0\RuOFb6AcQ}B_F/^%;;AmS%><zZ_q?N1w1%1voDY7#Ywj~qRaL7].8HB'2~pDUS|{E=$R\-s?;+p!RCe:w||kS\T@[(eQHB*-8u;~)ZP4;QYUI`|GJ)NS\`jLbW<e'R*y+Od,S5D+Vz++a<[$g'>"qr*^0t%eriBMe_x]B7&@b8_\i<A/A@T
Message-ID: <slrn-0.9.7.4-4729-165-200411051409-tc@hexane.ssi.swin.edu.au>
Date: Fri, 5 Nov 2004 14:10:35 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Elladan <elladan@eskimo.com> said on Thu, 4 Nov 2004 18:38:50 -0800:
> If a process is in D state and receives a SIGKILL, assume it must exit
> within a few seconds or it's a bug, and dump as much information about
> it as is practical...?

Of course, it's not necessarily a bug. Someone could have just kicked
the ethernet, and so your process is stuck waiting for a read/write.

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
Theoretically one might have been wearing pants at work.
        -- Anthony de Boer in Scary Devil Monastry
