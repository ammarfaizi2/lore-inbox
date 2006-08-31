Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932438AbWHaS0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbWHaS0H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 14:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbWHaS0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 14:26:07 -0400
Received: from 82-69-39-138.dsl.in-addr.zen.co.uk ([82.69.39.138]:56726 "EHLO
	ty.sabi.co.UK") by vger.kernel.org with ESMTP id S932440AbWHaS0E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 14:26:04 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17655.10676.495815.148740@base.ty.sabi.co.UK>
Date: Thu, 31 Aug 2006 19:25:56 +0100
X-Face: SMJE]JPYVBO-9UR%/8d'mG.F!@.,l@c[f'[%S8'BZIcbQc3/">GrXDwb#;fTRGNmHr^JFb
 SAptvwWc,0+z+~p~"Gdr4H$(|N(yF(wwCM2bW0~U?HPEE^fkPGx^u[*[yV.gyB!hDOli}EF[\cW*S
 H<GG"+i\3#fp@@EeWZWBv;]LA5n1pS2VO%Vv[yH?kY'lEWr30WfIU?%>&spRGFL}{`bj1TaD^l/"[
 msn( /TH#THs{Hpj>)]f><W}Ck9%2?H"AEM)+9<@D;3Kv=^?4$1/+#Qs:-aSsBTUS]iJ$6
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: A nice CPU resource controller
In-Reply-To: <44F5AB45.8030109@control.lth.se>
References: <44F5AB45.8030109@control.lth.se>
X-Mailer: VM 7.17 under 21.4 (patch 19) XEmacs Lucid
From: pg_lkm@lkm.for.sabi.co.UK (Peter Grandi)
X-Disclaimer: This message contains only personal opinions
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On Wed, 30 Aug 2006 17:14:13 +0200, Martin Ohlin
>>> <martin.ohlin@control.lth.se> said:

martin.ohlin> To those interested I have been working on a CPU
martin.ohlin> resource controller using the nice value as a
martin.ohlin> control signal. At the moment, the control is done
martin.ohlin> on a per-task-level, but I have plans to extend it
martin.ohlin> to groups of tasks. [ ... ]

This reminds me of fair share schedulers, which were popular
some decades ago on mainframes and early UNIX systems.

* G. J. Henry "The fair share scheduler AT&T", Bell
  Lab.Tech. J. 1845-1857 63, 8 (Oct.).

* Judy Kay, Piers Lauder "A Fair Share Scheduler CACM", 31:1,
  44-55 January 1988. <http://WWW.CS.USyd.edu.AU/~piers/>

* %A J. Larmouth
  %T Scheduling for a share of the machine
  %J SPE
  %V 5
  %N 1
  %D JAN 1975
  %P 29-49
  %X <URL:http://WWW.CL.Cam.ac.UK/TechReports/UCAM-CL-TR-2.pdf>

* %A J. Larmouth
  %T Scheduling for immediate turnround
  %J SPE
  %V 8
  %D 1978
  %P 559-578
