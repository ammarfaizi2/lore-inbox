Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264273AbTEOWyD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 18:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264274AbTEOWyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 18:54:03 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12037 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264273AbTEOWyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 18:54:01 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: don't use cheap switches under some scenarios
Date: 15 May 2003 16:06:41 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <ba16i1$7eg$1@cesium.transmeta.com>
References: <Pine.GSO.4.44.0305101411001.11628-100000@unix.cs.tamu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.GSO.4.44.0305101411001.11628-100000@unix.cs.tamu.edu>
By author:    Xinwen Fu <xinwenfu@cs.tamu.edu>
In newsgroup: linux.dev.kernel
>
> Hi, all,
> 	I asked before why my linksys workgroup 5-port switch worked like
> a hub
> under heavy traffic (10mb/s) into one socket of the switch. The conclusion
> is that the switch has some problem.
> 
> 	In fact, for the first 5 minutes, it
> works like a switch and then it works like a hub. The switching table is
> messed up by the intense traffic, we believe. Other cheaper switches
> (netgear fast esthernet switch FS108 ) have the same problem. We use a
> CentreCom FS708, and then the problem is solved. Of course other expensive
> and professional switches should be ok too, we think.
> 

Do you have lots of machines on your network?  All switches has a
limit on the number of MACs they can remember.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
