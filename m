Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261945AbTCVCEJ>; Fri, 21 Mar 2003 21:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261947AbTCVCEJ>; Fri, 21 Mar 2003 21:04:09 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:54032 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261945AbTCVCEJ>; Fri, 21 Mar 2003 21:04:09 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch] Generic way to control display of debug printk's
Date: 21 Mar 2003 18:15:06 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b5ggva$2lu$1@cesium.transmeta.com>
References: <20030321223717.GA1241@bork.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030321223717.GA1241@bork.org>
By author:    Martin Hicks <mort@wildopensource.com>
In newsgroup: linux.dev.kernel
> 
> It seems to me that a generic way to dynamically control the printing
> of certain messages to the console during kernel boot is required.
> Systems that really need this are large SMP systems or NUMA machines
> with a large number of nodes.  The number of messages that appear 
> per-node or per-cpu is huge in these machines.
> 

See KERN_EMERG, KERN_ALERT, KERN_CRIT, KERN_ERR, KERN_WARNING,
KERN_NOTICE, KERN_INFO, KERN_DEBUG.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
