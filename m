Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264724AbSIQXzk>; Tue, 17 Sep 2002 19:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264743AbSIQXzk>; Tue, 17 Sep 2002 19:55:40 -0400
Received: from pizda.ninka.net ([216.101.162.242]:59268 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264724AbSIQXzj>;
	Tue, 17 Sep 2002 19:55:39 -0400
Date: Tue, 17 Sep 2002 16:51:31 -0700 (PDT)
Message-Id: <20020917.165131.81918297.davem@redhat.com>
To: ak@suse.de
Cc: johnstul@us.ibm.com, jamesclv@us.ibm.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, anton.wilson@camotion.com
Subject: Re: do_gettimeofday vs. rdtsc in the scheduler
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020918015838.A6684@wotan.suse.de>
References: <20020918015209.B31263@wotan.suse.de>
	<20020917.164649.110499262.davem@redhat.com>
	<20020918015838.A6684@wotan.suse.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: Wed, 18 Sep 2002 01:58:38 +0200
   
   The local APIC timer is specified in the Intel Manual volume 3 for example.
   It's an optional feature (CPUID), but pretty much everyone has it.

It is internal or external to the processor?  Ie. can it be in the
southbridge or something?  If yes, then I still hold my point.

You shouldn't have to PIO to get a reliable timer value.
