Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315415AbSHVRbx>; Thu, 22 Aug 2002 13:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315416AbSHVRbx>; Thu, 22 Aug 2002 13:31:53 -0400
Received: from AMarseille-201-1-2-125.abo.wanadoo.fr ([193.253.217.125]:20592
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S315415AbSHVRa6>; Thu, 22 Aug 2002 13:30:58 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dominik Brodowski <devel@brodo.de>, Gabriel Paubert <paubert@iram.es>
Cc: Yoann Vandoorselaere <yoann@prelude-ids.org>,
       <cpufreq@lists.arm.linux.org.uk>, <cpufreq@www.linux.org.uk>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]: fix 32bits integer overflow in loops_per_jiffy
 calculation
Date: Thu, 22 Aug 2002 21:35:16 +0200
Message-Id: <20020822193516.15445@192.168.4.1>
In-Reply-To: <20020822185107.A1160@brodo.de>
References: <20020822185107.A1160@brodo.de>
X-Mailer: CTM PowerMail 3.1.2 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>IMHO per-arch functions are really not needed. The only architectures which
>have CPUFreq drivers by now are ARM and i386. This will change, hopefully;
>IMHO it should be enough to include some basic limit checking in 
>cpufreq_scale().

In this specific case, we were talking about PPC since the problem
occured when I implemented cpufreq support to switch the speed
of the latest powerbooks between 667 and 800Mhz

Ben.


