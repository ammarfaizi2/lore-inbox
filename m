Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261693AbSJYXoh>; Fri, 25 Oct 2002 19:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261701AbSJYXoh>; Fri, 25 Oct 2002 19:44:37 -0400
Received: from dsl-213-023-039-129.arcor-ip.net ([213.23.39.129]:26284 "EHLO
	starship") by vger.kernel.org with ESMTP id <S261693AbSJYXog>;
	Fri, 25 Oct 2002 19:44:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: "Nakajima, Jun" <jun.nakajima@intel.com>, Jeff Garzik <jgarzik@pobox.com>,
       Robert Love <rml@tech9.net>
Subject: Re: [PATCH] hyper-threading information in /proc/cpuinfo
Date: Sat, 26 Oct 2002 01:51:25 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "'Dave Jones'" <davej@codemonkey.org.uk>,
       "'akpm@digeo.com'" <akpm@digeo.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'chrisl@vmware.com'" <chrisl@vmware.com>,
       "'Martin J. Bligh'" <mbligh@aracnet.com>
References: <F2DBA543B89AD51184B600508B68D4000ECE7086@fmsmsx103.fm.intel.com>
In-Reply-To: <F2DBA543B89AD51184B600508B68D4000ECE7086@fmsmsx103.fm.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E185EEg-0008SQ-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 26 October 2002 00:42, Nakajima, Jun wrote:
> The notion of "SMT (Simultaneous Multi-Threaded)" architecture has been
> there for a while (at least 8 years, as far as I know). You would get tons
> of info if you search it in Internet. 

Actually, what we were referring to is multiple complete, separate
processor cores on one chip.  Two complete cores turns in true 2X
performance, modulo cache effects, vs SMT which turns in anywhere
from 0 to 20% improvement.

MIPS does 2X processors/chip, and IBM is planning to do 32X.  I've
heard rumours of 128X as well.

-- 
Daniel
